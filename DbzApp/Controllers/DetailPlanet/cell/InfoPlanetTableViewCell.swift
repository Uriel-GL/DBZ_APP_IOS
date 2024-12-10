//
//  InfoPlanetTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 05/12/24.
//

import UIKit

class InfoPlanetTableViewCell: UITableViewCell {

    static var identifier: String = "InfoPlanetTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var stackCards: UIStackView!
    @IBOutlet weak var viewCard1: UIView!
    @IBOutlet weak var viewCard2: UIView!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelAfiliation: UILabel!
    @IBOutlet weak var labelGenderDesc: UILabel!
    @IBOutlet weak var labelAfiliationDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.labelTitle.font = UIFont(name: "Oswald", size: 22)
        self.labelTitle.textColor = DBZAppColors.primary.color
        self.labelDescription.font = UIFont(name: "Oswald", size: 18)
        
        self.viewCard1.layer.cornerRadius = 12
        self.viewCard2.layer.cornerRadius = 12
        self.viewCard1.backgroundColor = .systemBackground
        self.viewCard2.backgroundColor = .systemBackground
        
        self.viewCard1.layer.borderColor = UIColor.gray.cgColor
        self.viewCard1.layer.borderWidth = 0.3
        self.viewCard1.layer.shadowOpacity = 0.3
        self.viewCard1.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.viewCard2.layer.borderColor = UIColor.gray.cgColor
        self.viewCard2.layer.borderWidth = 0.3
        self.viewCard2.layer.shadowOpacity = 0.3
        self.viewCard2.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.labelGender.textColor = DBZAppColors.primary.color
        self.labelAfiliation.textColor = DBZAppColors.primary.color
        
        self.labelGender.font = UIFont(name: "Oswald", size: 20)
        self.labelGenderDesc.font = UIFont(name: "Oswald", size: 18)
        self.labelAfiliation.font = UIFont(name: "Oswald", size: 20)
        self.labelAfiliationDesc.font = UIFont(name: "Oswald", size: 18)
        
        self.stackCards.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
