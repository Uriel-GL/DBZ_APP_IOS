//
//  ColorExt.swift
//  DbzApp
//
//  Created by Uriel GL on 17/10/24.
//

import Foundation
import UIKit

extension UIColor {
    
    ///  Extension la cual ayudara a poder utilizar colores hex en el proyecto
    /// - Parameter hex: String de valor hexadecimal --> #FFFFF
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
                
        var rgb: UInt64 = 0
                
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
                
        let length = hexSanitized.count
        let r, g, b, a: CGFloat
                
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
                
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
