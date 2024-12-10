//
//  PowerInfoTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 10/12/24.
//

import UIKit

class PowerInfoTableViewCell: UITableViewCell {

    static let identifier: String = "PowerInfoTableViewCell"
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewContainer1: UIView!
    @IBOutlet weak var viewContainer2: UIView!
    @IBOutlet weak var labelTitle1: UILabel!
    @IBOutlet weak var labelTitle2: UILabel!
    @IBOutlet weak var labelKiBase: UILabel!
    @IBOutlet weak var labelKiMaximo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.viewContainer1.layer.cornerRadius = 12
        self.viewContainer2.layer.cornerRadius = 12
        
        self.viewContainer1.layer.borderColor = UIColor.gray.cgColor
        self.viewContainer1.layer.borderWidth = 0.3
        self.viewContainer1.layer.shadowOpacity = 0.3
        self.viewContainer1.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.viewContainer2.layer.borderColor = UIColor.gray.cgColor
        self.viewContainer2.layer.borderWidth = 0.3
        self.viewContainer2.layer.shadowOpacity = 0.3
        self.viewContainer2.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.labelTitle.font = UIFont(name: "Oswald", size: 22)
        self.labelTitle1.font = UIFont(name: "Oswald", size: 16)
        self.labelTitle2.font = UIFont(name: "Oswald", size: 16)
        self.labelKiBase.font = UIFont(name: "Oswald", size: 17)
        self.labelKiMaximo.font = UIFont(name: "Oswald", size: 17)
        
        self.labelKiBase.textColor = DBZAppColors.primary.color
        self.labelKiMaximo.textColor = DBZAppColors.primary.color
        self.labelTitle.textColor = DBZAppColors.primary.color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
