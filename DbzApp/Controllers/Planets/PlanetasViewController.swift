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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}

//  MARK: - Configuración del contenido de la tabla
extension PlanetasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaginationTableViewCell.identifier, for: indexPath) as! PaginationTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.identifier, for: indexPath) as! PlanetTableViewCell
            return cell
        default:
            debugPrint("Seccion no valida")
            return UITableViewCell()
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
    func backPage() { // Retroceder una pagina
        
    }
    
    func nextPage() { // Avanzar una pagina
        
    }
}
