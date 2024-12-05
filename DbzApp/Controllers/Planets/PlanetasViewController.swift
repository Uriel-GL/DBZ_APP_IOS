//
//  PlanetasViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 28/10/24.
//

import UIKit

class PlanetasViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var planets: [Planet] = []
    var meta: Meta? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuración del ActivityIndicator
        self.activityIndicator.style = .large
        self.activityIndicator.color = DBZAppColors.primary.color
        self.activityIndicator.hidesWhenStopped = true
        
        //Configuración del texto con un como efecto delineado
        let strokeTitleAttribbutes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DBZAppColors.secondary.color as Any,
            .strokeColor: UIColor.black,
            .strokeWidth: -2.0,
            .font: UIFont(name: "SaiyanSans", size: 37) ?? UIFont.systemFont(ofSize: 37)
        ]
        
        self.labelTitle.attributedText = NSAttributedString(string: "Planetas", attributes: strokeTitleAttribbutes)
        
        self.tableView.register(PlanetTableViewCell.nib, forCellReuseIdentifier: PlanetTableViewCell.identifier)
        self.tableView.register(PaginationTableViewCell.nib, forCellReuseIdentifier: PaginationTableViewCell.identifier)
        
        self.tableView.contentInset.bottom = 8.0
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        getDataPlanets(numPage: 1)
    }
    
    func getDataPlanets(numPage: Int) {
        startLoader()
        API.getAllPlanets(numPage: numPage) { [weak self] response in
            self?.stopLoader()
            switch response {
            case .success(let data):
                self?.planets = data.items
                self?.meta = data.meta
                
                self?.tableView.reloadData()
            case .failure(let error):
                debugPrint("Error \(error)")
            }
        }.excecute()
    }
    
    func startLoader() {
        self.activityIndicator.startAnimating()
    }
    
    func stopLoader() {
        self.activityIndicator.stopAnimating()
    }
}

//  MARK: - Configuración del contenido de la tabla
extension PlanetasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // Paginador
            return 1
        case 1: // Planetas
            return self.planets.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaginationTableViewCell.identifier, for: indexPath) as! PaginationTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            guard let meta = self.meta else { return cell }
            cell.configure(with: meta)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.identifier, for: indexPath) as! PlanetTableViewCell
            let planet = self.planets[indexPath.row]
            cell.configure(with: planet)
            return cell
        default:
            debugPrint("Seccion no valida")
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(DetailPlanetViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 { // Solo afecta a los cards de los planetas
            return 180
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension PlanetasViewController: PaginationTableViewCellDelegate {
    func backPage(numPage: Int) { // Retroceder una pagina
        debugPrint("Back: \(numPage)")
        self.getDataPlanets(numPage: numPage)
    }
    
    func nextPage(numPage: Int) { // Avanzar una pagina
        debugPrint("Next: \(numPage)")
        self.getDataPlanets(numPage: numPage)
    }
}
