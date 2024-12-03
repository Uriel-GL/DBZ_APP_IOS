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
        
        self.collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        
        return cell
    }
}

//MARK: - Tamaños y proporciones de las celdas
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // Método para definir el tamaño de las celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200) //Tamaño de la celda
    }
    
    // Espaciado entre filas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Ajusta este valor para reducir el espacio vertical entre celdas
    }
    
    // Espaciado entre columnas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Ajusta este valor para reducir el espacio horizontal entre celdas
    }
    
    // Márgenes de la sección
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}
