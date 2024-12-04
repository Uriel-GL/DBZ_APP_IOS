//
//  HomeViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 16/10/24.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    var characters: [CharacterDBZ] = []
    var meta: Meta? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for family in UIFont.familyNames {
//            debugPrint(family)
//            for name in UIFont.fontNames(forFamilyName: family) {
//                debugPrint(name)
//            }
//        } //SaiyanSans -  Oswald
        
        // Configuración del ActivityIndicator
        self.loaderIndicator.style = .large
        self.loaderIndicator.color = DBZAppColors.primary.color
        self.loaderIndicator.hidesWhenStopped = true
        
        //Configuración del texto con un como efecto delineado
        let strokeTitleAttribbutes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DBZAppColors.secondary.color as Any,
            .strokeColor: UIColor.black,
            .strokeWidth: -2.0,
            .font: UIFont(name: "SaiyanSans", size: 37) ?? UIFont.systemFont(ofSize: 37)
        ]
        
        self.labelTitle.attributedText = NSAttributedString(string: "Personajes", attributes: strokeTitleAttribbutes)
        
        self.collectionView.register(CharacterCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        self.collectionView.register(PaginatorCollectionViewCell.nib, forCellWithReuseIdentifier: PaginatorCollectionViewCell.indetifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Se setea el 1 ya que al primer inicio de la app muestre la pagina 1 de la API
        getDataCharacters(numPage: 1)
    }
    
    func getDataCharacters(numPage: Int) {
        starLoader()
        API.getAllCharacters(numPage: numPage) { [weak self] response in
            self?.stopLoader()
            switch response {
            case .success(let data):
                self?.characters = data.items
                self?.meta = data.meta
                
                self?.collectionView.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
        }.excecute()
    }
    
    func starLoader() {
        self.loaderIndicator.startAnimating()
    }
    
    func stopLoader() {
        self.loaderIndicator.stopAnimating()
    }
}

//MARK: - Configuración del collectionView de Home
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: // Paginador
            return 1
        case 1: // Personajes
            return self.characters.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaginatorCollectionViewCell.indetifier, for: indexPath) as! PaginatorCollectionViewCell
            cell.delegate = self
            guard let meta = self.meta else { return cell }
            cell.configure(with: meta)
            return cell
        case (1, _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
            let character = self.characters[indexPath.row]
            cell.configure(with: character)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - Tamaños y proporciones de las celdas
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // Método para definir el tamaño de las celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let sectionInset = 20
        
        switch indexPath.section {
        case 0:
            return CGSize(width: screenWidth - 10 * 2, height: 50) //Tamaño de la celda para el paginador
        case 1:
            let numberOfColumns = 2
            let totalSpacing = 10 * (numberOfColumns - 1) + sectionInset * 2
            return CGSize(width: (Int(screenWidth) - totalSpacing) / numberOfColumns, height: 200) //Tamaño para los cards
        default:
            return CGSize(width: 160, height: 200) //Tamaño por defecto
        }
    }
    
    // Espacio entre filas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espacio vertical entre celdas
    }
    
    // Espacio entre columnas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espacio horizontal entre celdas
    }
    
    // Márgenes de la sección
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 7, right: 20)
    }
}

extension HomeViewController: PaginatorCollectionViewCellDelegate {
    func backPage(numPage: Int) {
        debugPrint("Pagina BACK: \(numPage)")
        self.getDataCharacters(numPage: numPage)
    }
    
    func nextPage(numPage: Int) {
        debugPrint("Pagina NEXT: \(numPage)")
        self.getDataCharacters(numPage: numPage)
    }
}
