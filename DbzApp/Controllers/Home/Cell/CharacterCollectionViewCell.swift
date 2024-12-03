//
//  CharacterCollectionViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 16/10/24.
//

import UIKit

/// Celda Personalizada para representar un personaje de Dragon Ball
class CharacterCollectionViewCell: UICollectionViewCell {
    
    public static var identifier = "CharacterCollectionViewCell"

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContainer.layer.cornerRadius = 15
        self.labelName.font = UIFont(name: "Oswald", size: 22)
    }
    
    //Metodo que nos ayudara a configurar la celda y sus componentes.
    func configure() {
        
    }

}
