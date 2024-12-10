//
//  NoTransformationsTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 10/12/24.
//

import UIKit

class NoTransformationsTableViewCell: UITableViewCell {

    static var identifier: String = "NoTransformationsTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.label.font = UIFont(name: "Oswald", size: 22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
