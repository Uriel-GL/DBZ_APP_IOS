//
//  CardPlanetTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 05/12/24.
//

import UIKit

class CardPlanetTableViewCell: UITableViewCell {

    static var identifier: String = "CardPlanetTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imagePlanet: UIImageView!
    @IBOutlet weak var labelNamePlanet: UILabel!
    @IBOutlet weak var labelEstatusPlanet: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imagePlanet.layer.cornerRadius = 10
        
        self.viewContainer.layer.cornerRadius = 10
        self.viewContainer.backgroundColor = .systemBackground
        self.label1.textColor = DBZAppColors.primary.color
        self.label2.textColor = DBZAppColors.primary.color
        
        self.label1.font = UIFont(name: "Oswald", size: 22)
        self.label2.font = UIFont(name: "Oswald", size: 22)
        self.labelNamePlanet.font = UIFont(name: "Oswald", size: 22)
        self.labelEstatusPlanet.font = UIFont(name: "Oswald", size: 22)
        
        self.viewContainer.layer.borderColor = UIColor.gray.cgColor
        self.viewContainer.layer.borderWidth = 0.2
        self.viewContainer.layer.shadowColor = UIColor.gray.cgColor
        self.viewContainer.layer.shadowRadius = 10
        self.viewContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.viewContainer.layer.shadowOpacity = 0.4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, statusPlanet: Bool, namePlanet: String) {
        self.labelNamePlanet.text = namePlanet
        self.labelEstatusPlanet.text = statusPlanet ? "Planeta destruido" : "Planeta aun intacto"
        
        guard let url = URL(string: image) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Ocurrio un error al obtener la data")
            }
            
            guard let data = data, let imageData = UIImage(data: data) else {
                debugPrint("Error al obtener la imagen")
                return
            }
            
            DispatchQueue.main.async {
                self.imagePlanet.image = imageData
            }
        }
        task.resume()
    }
}
