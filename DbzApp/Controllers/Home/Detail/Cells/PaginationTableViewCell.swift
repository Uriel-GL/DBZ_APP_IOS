//
//  PaginationTableViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 02/12/24.
//

import UIKit

protocol PaginationTableViewCellDelegate: AnyObject {
    func backPage(numPage: Int)
    func nextPage(numPage: Int)
}

class PaginationTableViewCell: UITableViewCell {

    static var identifier: String = "PaginationTableViewCell"
    static var nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    var delegate: PaginationTableViewCellDelegate? = nil
    
    @IBOutlet weak var labelNumCharacters: UILabel!
    @IBOutlet weak var labelNumPage: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    var meta: Meta? = nil
    var currentPage = 1
    var currentCharacters = 0
    var lastCount = 0
    var isButtonBackPressed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.labelNumCharacters.font = UIFont(name: "Oswald", size: 18)
        self.labelNumPage.font = UIFont(name: "Oswald", size: 14)
        
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
        if let meta = self.meta {
            self.lastCount = meta.itemCount
            self.isButtonBackPressed = true
            self.buttonBack.isEnabled = !(self.currentPage == 1)
            let numPage = self.currentPage - 1
            if numPage >= 1 {
                self.delegate?.backPage(numPage: numPage)
            }
        }
    }
    
    @IBAction func actionNext(_ sender: Any) {
        if let meta = self.meta {
            self.lastCount = meta.itemCount
            self.isButtonBackPressed = false
            self.buttonNext.isEnabled = !(self.currentPage == meta.totalPages)
            let numPage = self.currentPage + 1
            if numPage <= meta.totalPages {
                self.delegate?.nextPage(numPage: numPage)
            }
        }
    }
    
    // Función la cual nos ayudara a configurar el label y los botones iniciales con la data de la Api
    func configure(with meta: Meta) {
        self.meta = meta
        self.currentPage = meta.currentPage
        
        self.labelNumPage.text = "Pagina \(self.currentPage) de \(meta.totalPages)"
        if self.isButtonBackPressed {
            self.currentCharacters -= self.lastCount
            self.labelNumCharacters.text = "Planetas 10 de \(meta.totalItems)"
        } else {
            self.currentCharacters += meta.itemCount
            self.labelNumCharacters.text = "Planetas 10 de \(meta.totalItems)"
        }
        
        self.buttonBack.isEnabled = !(currentPage == 1)
        self.buttonNext.isEnabled = !(currentPage == meta.totalPages)
    }
}
