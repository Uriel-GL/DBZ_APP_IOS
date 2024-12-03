//
//  PaginationTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 02/12/24.
//

import UIKit

protocol PaginationTableViewCellDelegate: AnyObject {
    func backPage()
    func nextPage()
}

class PaginationTableViewCell: UITableViewCell {

    static var identifier: String = "PaginationTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    var delegate: PaginationTableViewCellDelegate? = nil
    
    @IBOutlet weak var labelNumCharacters: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelNumCharacters.font = UIFont(name: "Oswald", size: 18)
        self.labelNumCharacters.text = "Planetas 10 de 50"
        
        self.buttonBack.tintColor = DBZAppColors.primary.color
        self.buttonNext.tintColor = DBZAppColors.primary.color
        self.buttonBack.layer.masksToBounds = true
        self.buttonNext.layer.masksToBounds = true
        self.buttonBack.layer.cornerRadius = 20
        self.buttonNext.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.delegate?.backPage()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        self.delegate?.nextPage()
    }
    
    // Función la cual nos ayudara a configurar el label y los botones iniciales con la data de la Api
    func configure() {
        
    }
}
