//
//  CardInfoTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 09/12/24.
//

import UIKit

class CardInfoTableViewCell: UITableViewCell {

    static let identifier: String = "CardInfoTableViewCell"
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRace: UILabel!
    @IBOutlet weak var labelPlanet: UILabel!
    @IBOutlet weak var labelNamePlanet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.labelName.font = UIFont(name: "Oswald", size: 36)
        self.labelRace.font = UIFont(name: "Oswald", size: 22)
        
        self.labelPlanet.font = UIFont(name: "Oswald", size: 28)
        self.labelNamePlanet.font = UIFont(name: "Oswald", size: 22)
        
        self.labelName.textColor = DBZAppColors.primary.color
        self.labelPlanet.textColor = DBZAppColors.primary.color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, name: String, race: String, namePlanet: String) {
        self.labelName.text = name
        self.labelRace.text = race
        self.labelNamePlanet.text = namePlanet
        
        guard let url = URL(string: image) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Ocurrio un error al consultar la imagen")
            }
            
            guard let data = data, let imageData = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageCharacter.image = imageData
            }
        }
        task.resume()
    }
}
