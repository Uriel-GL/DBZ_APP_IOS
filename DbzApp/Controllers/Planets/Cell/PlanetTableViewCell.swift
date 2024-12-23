//
//  PlanetTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 31/10/24.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    
    static var nib: UINib = UINib(nibName: "PlanetTableViewCell", bundle: nil)
    static var identifier: String = "PlanetTableViewCell"

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imagePlanet: UIImageView!
    @IBOutlet weak var labelNamePlanet: UILabel!
    @IBOutlet weak var labelEstatusPlanet: UILabel!
    
    var planet: Planet? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setUpBorder()
        self.imagePlanet.layer.cornerRadius = 10
        
        self.labelTitle.layer.cornerRadius = 10
        self.labelTitle.backgroundColor = DBZAppColors.primary.color
        self.labelTitle.layer.masksToBounds = true
        self.labelTitle.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        self.labelNamePlanet.font = UIFont(name: "Oswald", size: 18)
        self.labelEstatusPlanet.font = UIFont(name: "Oswald", size: 17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpBorder() {
        self.viewContainer.layer.cornerRadius = 10
        self.viewContainer.clipsToBounds = true
        
        self.viewContainer.layer.borderColor = UIColor.gray.cgColor
        self.viewContainer.layer.borderWidth = 1.0
        
        self.viewContainer.layer.shadowOpacity = 0.3
        self.viewContainer.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        self.viewContainer.layer.shadowRadius = 1
    }
    
    func configure(with planet: Planet) {
        self.planet = planet
        
        let text = "Planeta:\n\(planet.name)"
        let text2 = planet.isDestroyed ? "Estado:\nDestruido" : "Estado:\nPlaneta aun intacto"

        let atributtedText = NSMutableAttributedString(string: text)
        let rangeText = (text as NSString).range(of: "Planeta:")
        atributtedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: rangeText)
        atributtedText.addAttribute(.foregroundColor, value: DBZAppColors.primary.color, range: rangeText)
        self.labelNamePlanet.attributedText = atributtedText
        
        let atributtedText2 = NSMutableAttributedString(string: text2)
        let rangeText2 = (text2 as NSString).range(of: "Estado:")
        atributtedText2.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: rangeText2)
        atributtedText2.addAttribute(.foregroundColor, value: DBZAppColors.primary.color, range: rangeText2)
        self.labelEstatusPlanet.attributedText = atributtedText2
        
        guard let url = URL(string: planet.image) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Ocurrio un error al obtener la imagen")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                debugPrint("Error al procesar la imagen")
                return
            }
            
            DispatchQueue.main.async {
                self.imagePlanet.image = image
            }
        }
        task.resume()
    }
}
