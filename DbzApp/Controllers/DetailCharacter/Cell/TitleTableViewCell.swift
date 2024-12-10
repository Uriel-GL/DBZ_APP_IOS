//
//  TitleTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 10/12/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier: String = "TitleTableViewCell"
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.label.font = UIFont(name: "Oswald", size: 22)
        self.label.textColor = DBZAppColors.primary.color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
