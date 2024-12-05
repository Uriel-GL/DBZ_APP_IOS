//
//  DetailPlanetViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 05/12/24.
//

import UIKit

class DetailPlanetViewController: UIViewController {

    @IBOutlet weak var tableViewDetail: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewDetail.dataSource = self
        self.tableViewDetail.delegate = self
        self.tableViewDetail.rowHeight = UITableView.automaticDimension
        
        self.tableViewDetail.register(CardPlanetTableViewCell.nib, forCellReuseIdentifier: CardPlanetTableViewCell.identifier)
        self.tableViewDetail.register(InfoPlanetTableViewCell.nib, forCellReuseIdentifier: InfoPlanetTableViewCell.identifier)
        self.tableViewDetail.register(CharacterPlanetTableViewCell.nib, forCellReuseIdentifier: CharacterPlanetTableViewCell.identifier)
        self.tableViewDetail.separatorStyle = .none
    }
}

extension DetailPlanetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cardCell = tableView.dequeueReusableCell(withIdentifier: CardPlanetTableViewCell.identifier, for: indexPath) as! CardPlanetTableViewCell
            return cardCell
        case 1:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoPlanetTableViewCell.identifier, for: indexPath) as! InfoPlanetTableViewCell
            return infoCell
        case 2:
            let characterCell = tableView.dequeueReusableCell(withIdentifier: CharacterPlanetTableViewCell.identifier, for: indexPath) as! CharacterPlanetTableViewCell
            return characterCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 380
        } else if indexPath.section == 2 {
            let itemCount = 9 //Número de personajes a mostrar
            let cellHeight: CGFloat = 210 // Tamaño de la celda del collectionView
            let verticalSpacing: CGFloat = 10 // Espacio vertical del CollectionView
            let sectionInset: CGFloat = 20 // Espacio entre celdas
            
            let newValue = calculateCollectionViewHeight(forItems: itemCount, cellHeight: cellHeight, verticalSpacing: verticalSpacing, sectionInset: sectionInset)
            
            return newValue
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func calculateCollectionViewHeight(forItems itemCount: Int, cellHeight: CGFloat, verticalSpacing: CGFloat, sectionInset: CGFloat) -> CGFloat {
        // Define el número de columnas
        let numberOfColumns = 2
        
        // Calcula el número de filas necesarias
        let numberOfRows = ceil(Double(itemCount) / Double(numberOfColumns))
        
        // Altura total de las filas
        let totalRowsHeight = CGFloat(numberOfRows) * cellHeight
        
        // Espaciado entre filas
        let totalSpacing = CGFloat(numberOfRows - 1) * verticalSpacing
        
        // Margen superior e inferior
        let totalInsets = sectionInset * 2
        
        // Altura total
        return totalRowsHeight + totalSpacing + totalInsets + 30
    }
}
