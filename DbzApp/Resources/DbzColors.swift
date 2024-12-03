//
//  DbzColors.swift
//  DbzApp
//
//  Created by Uriel GL on 17/10/24.
//

import Foundation
import UIKit

enum DBZAppColors: String {
    case primary = "#F47A20"
    case secondary = "#ffce00"
    case text = "#8A000000"
    case titles = "#DD000000"
    
    var color: UIColor {
        return UIColor(hex: self.rawValue) ?? UIColor.green
    }
}
