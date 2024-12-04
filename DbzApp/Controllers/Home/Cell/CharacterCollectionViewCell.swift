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
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    var character: CharacterDBZ? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContainer.layer.cornerRadius = 15
        self.labelName.font = UIFont(name: "Oswald", size: 22)
    }
    
    //Metodo que nos ayudara a configurar la celda y sus componentes.
    func configure(with character: CharacterDBZ) {
        self.character = character
        
        self.labelName.text = character.name
        
        guard let url = URL(string: character.image) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Error al obtener la imagen \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                debugPrint("Error al procesar la imagen")
                return
            }
            
            DispatchQueue.main.async {
                self.imageCharacter.image = image
            }
        }
        task.resume()
    }

}
