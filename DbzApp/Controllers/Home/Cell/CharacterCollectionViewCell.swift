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
    
    //Metodo que nos ayudara a configurar la celda si es un personaje oh una trasnformación.
    func configure<T>(item: T?) {
        self.imageCharacter.image = nil
        
        if let character = item as? CharacterDBZ {
            self.labelName.text = character.name
            guard let url = URL(string: character.image) else { return }
            loadImage(url: url)
        }
        
        if let transformation = item as? Transformation {
            self.labelName.text = transformation.name
            guard let url = URL(string: transformation.image) else { return }
            loadImage(url: url)
        }
    }
    
    func loadImage(url: URL) {
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
    
    func setUpShadow() {
        self.viewContainer.backgroundColor = .systemBackground
        self.viewContainer.layer.shadowOpacity = 0.3
        self.viewContainer.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        self.viewContainer.layer.borderColor = UIColor.gray.cgColor
        self.viewContainer.layer.borderWidth = 1.0
        self.viewContainer.layer.masksToBounds = true
    }
}
