//
//  DetailCharacterViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 09/12/24.
//

import UIKit

class DetailCharacterViewController: UIViewController {

    @IBOutlet weak var tableDetailCharacter: UITableView!
    
    var character: CharacterDBZ? = nil {
        didSet {
            self.tableDetailCharacter.reloadData()
        }
    }
    
    init(character: CharacterDBZ) {
        self.character = character
        super.init(nibName: "DetailCharacterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.character?.name
        
        self.tableDetailCharacter.dataSource = self
        self.tableDetailCharacter.delegate = self
        
        self.tableDetailCharacter.register(CardInfoTableViewCell.nib, forCellReuseIdentifier: CardInfoTableViewCell.identifier)
        self.tableDetailCharacter.register(PowerInfoTableViewCell.nib, forCellReuseIdentifier: PowerInfoTableViewCell.identifier)
        self.tableDetailCharacter.register(InfoPlanetTableViewCell.nib, forCellReuseIdentifier: InfoPlanetTableViewCell.identifier)
        self.tableDetailCharacter.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.identifier)
        self.tableDetailCharacter.register(PlanetTableViewCell.nib, forCellReuseIdentifier: PlanetTableViewCell.identifier)
        self.tableDetailCharacter.register(CharacterPlanetTableViewCell.nib, forCellReuseIdentifier: CharacterPlanetTableViewCell.identifier)
        self.tableDetailCharacter.register(NoTransformationsTableViewCell.nib, forCellReuseIdentifier: NoTransformationsTableViewCell.identifier)
        
        self.tableDetailCharacter.separatorStyle = .none
    }
}

extension DetailCharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 2
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellInfo = tableView.dequeueReusableCell(withIdentifier: CardInfoTableViewCell.identifier, for: indexPath) as! CardInfoTableViewCell
            cellInfo.configure(
                image: self.character?.image ?? "",
                name: self.character?.name ?? "Desconocido",
                race: self.character?.race ?? "Terricola",
                namePlanet: self.character?.originPlanet?.name ?? "Desconocido"
            )
            return cellInfo
        case 1:
            let cellPower = tableView.dequeueReusableCell(withIdentifier: PowerInfoTableViewCell.identifier, for: indexPath) as! PowerInfoTableViewCell
            cellPower.labelKiBase.text = self.character?.ki
            cellPower.labelKiMaximo.text = self.character?.maxKi
            return cellPower
        case 2:
            let cellDesc = tableView.dequeueReusableCell(withIdentifier: InfoPlanetTableViewCell.identifier, for: indexPath) as! InfoPlanetTableViewCell
            cellDesc.labelTitle.text = "Información del personaje"
            cellDesc.labelDescription.text = self.character?.description
            cellDesc.labelGenderDesc.text = self.character?.gender
            cellDesc.labelAfiliationDesc.text = self.character?.affiliation
            cellDesc.stackCards.isHidden = false
            return cellDesc
        case 3:
            switch indexPath.row {
            case 0:
                let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
                return titleCell
            case 1:
                let cellPlanet = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.identifier, for: indexPath) as! PlanetTableViewCell
                guard let planet = self.character?.originPlanet else { return cellPlanet }
                cellPlanet.configure(with: planet)
                return cellPlanet
            default:
                return UITableViewCell()
            }
        case 4:
            if self.character?.transformations?.count == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: NoTransformationsTableViewCell.identifier, for: indexPath) as! NoTransformationsTableViewCell
                cell.label.text = "Actualmente \(self.character?.name ?? "-") no tiene transformaciones registradas."
                return cell
            } else {
                let cellTransformations = tableView.dequeueReusableCell(withIdentifier: CharacterPlanetTableViewCell.identifier, for: indexPath) as! CharacterPlanetTableViewCell
                cellTransformations.labelTitle.text = "Transformaciones del personaje"
                cellTransformations.labelNum.isHidden = true
                cellTransformations.configure(
                    item: self.character?.transformations ?? [],
                    isDetailCharacter: true
                )
                return cellTransformations
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 4:
            let itemCount = self.character?.transformations?.count ?? 0 //Número de personajes a mostrar
            let cellHeight: CGFloat = 210 // Tamaño de la celda del collectionView
            let verticalSpacing: CGFloat = 10 // Espacio vertical del CollectionView
            let sectionInset: CGFloat = 20 // Espacio entre celdas
            
            if itemCount == 0 { //Tamaño fijo de la celda del mensaje
                return 160
            }
            
            let newValue = calculateCollectionViewHeight(forItems: itemCount, cellHeight: cellHeight, verticalSpacing: verticalSpacing, sectionInset: sectionInset)
            
            return newValue
        default:
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
