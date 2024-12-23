//
//  CharacterPlanetTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 05/12/24.
//

import UIKit

class CharacterPlanetTableViewCell: UITableViewCell {
    

    static var identifier: String = "CharacterPlanetTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNum: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var characters: [CharacterDBZ] = []
    var transformations: [Transformation] = []
    var isDetailCharacter: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.labelTitle.font = UIFont(name: "Oswald", size: 22)
        self.labelNum.font = UIFont(name: "Oswald", size: 22)
        self.labelTitle.textColor = DBZAppColors.primary.color
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(CharacterCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        
        self.collectionView.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configuración del contenido con personajes oh trasnformaciones
    func configure<T>(numCharacters: Int = 0, item: [T]?, isDetailCharacter: Bool = false) {
        if let characters = item as? [CharacterDBZ] {
            self.labelNum.text = "\(numCharacters)"
            self.labelNum.isHidden = false
            self.characters = characters
            self.isDetailCharacter = isDetailCharacter
            self.collectionView.reloadData()
        }
        
        if let trasnformations = item as? [Transformation] {
            self.transformations = trasnformations
            self.labelNum.isHidden = true
            self.isDetailCharacter = isDetailCharacter
            self.collectionView.reloadData()
        }
    }
}

extension CharacterPlanetTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isDetailCharacter {
            return self.transformations.count
        } else {
            return self.characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.setUpShadow()
        
        if isDetailCharacter {
            cell.configure(item: self.transformations[indexPath.row])
        } else {
            cell.configure(item: self.characters[indexPath.row])
        }
        
        return cell
    }
}

extension CharacterPlanetTableViewCell: UICollectionViewDelegateFlowLayout {
    // Método para definir el tamaño de las celdas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let sectionInset = 20
        
        //Tamaño para los cards
        let numberOfColumns = 2
        let totalSpacing = 10 * (numberOfColumns - 1) + sectionInset * 2
        return CGSize(width: (Int(screenWidth) - totalSpacing) / numberOfColumns, height: 200)
    }
    
    // Espacio entre filas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Espacio entre columnas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Márgenes de la sección
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 7, right: 20)
    }
}
