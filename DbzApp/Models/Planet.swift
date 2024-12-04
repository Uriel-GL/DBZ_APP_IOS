//
//  Planet.swift
//  DbzApp
//
//  Created by Uriel GL on 03/12/24.
//

import Foundation

class Planet: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
    let characters: [CharacterDBZ]?
}
