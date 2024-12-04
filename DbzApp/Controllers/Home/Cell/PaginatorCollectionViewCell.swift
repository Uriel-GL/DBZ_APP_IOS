//
//  PaginatorCollectionViewCell.swift
//  DbzApp
//
//  Created by Uriel GL on 04/12/24.
//

import UIKit

protocol PaginatorCollectionViewCellDelegate: AnyObject {
    func backPage(numPage: Int)
    func nextPage(numPage: Int)
}

class PaginatorCollectionViewCell: UICollectionViewCell {
    
    static var indetifier: String = "PaginatorCollectionViewCell"
    static var nib: UINib = UINib(nibName: indetifier, bundle: nil)

    @IBOutlet weak var labelNumCharacters: UILabel!
    @IBOutlet weak var labelNumPages: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    var delegate: PaginatorCollectionViewCellDelegate? = nil
    var meta: Meta? = nil
    var currentPage = 1
    var currentCharacters = 0
    var lastCount = 0
    var isButtonBackPressed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonBack.tintColor = DBZAppColors.primary.color
        self.buttonNext.tintColor = DBZAppColors.primary.color
        self.buttonBack.layer.masksToBounds = true
        self.buttonNext.layer.masksToBounds = true
        self.buttonBack.layer.cornerRadius = 20
        self.buttonNext.layer.cornerRadius = 20
    }
    
    func configure(with meta: Meta) {
        self.meta = meta
        self.currentPage = meta.currentPage
        
        self.labelNumCharacters.font = UIFont(name: "Oswald", size: 18)
        if self.isButtonBackPressed {
            self.currentCharacters -= self.lastCount
            self.labelNumCharacters.text = "Personajes \(self.currentCharacters) de \(meta.totalItems)"
        } else {
            self.currentCharacters += meta.itemCount
            self.labelNumCharacters.text = "Personajes \(self.currentCharacters) de \(meta.totalItems)"
        }
        
        self.labelNumPages.font = UIFont(name: "Oswald", size: 14)
        self.labelNumPages.text = "Pagina \(meta.currentPage) de \(meta.totalPages)"
        
        self.buttonBack.isEnabled = !(currentPage == 1)
        self.buttonNext.isEnabled = !(currentPage == meta.totalPages)
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        if let meta = self.meta {
            //Antes de recargar los datos guardo la cantidad de personajes en la pagina actual
            self.lastCount = meta.itemCount
            self.isButtonBackPressed = true
            self.buttonBack.isEnabled = currentPage > 1
            let numPage = self.currentPage - 1
            if  numPage >= 1 {
                self.delegate?.backPage(numPage: numPage)
            }
        }
    }
    
    @IBAction func actionNext(_ sender: Any) {
        if let meta = self.meta {
            //Antes de recargar los datos guardo la cantidad de personajes en la pagina actual
            self.lastCount = meta.itemCount
            self.isButtonBackPressed = false
            self.buttonNext.isEnabled = !(currentPage == meta.totalPages)
            let numPage = self.currentPage + 1
            if  numPage <=  meta.totalPages {
                self.delegate?.nextPage(numPage: numPage)
            }
        }
    }
}
