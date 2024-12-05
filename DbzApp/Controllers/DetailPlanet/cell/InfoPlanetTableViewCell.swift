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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.labelTitle.font = UIFont(name: "Oswald", size: 22)
        self.labelTitle.textColor = DBZAppColors.primary.color
        self.labelDescription.font = UIFont(name: "Oswald", size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
