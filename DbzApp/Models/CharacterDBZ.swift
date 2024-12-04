//
//  CharacterDBZ.swift
//  DbzApp
//
//  Created by Uriel GL on 03/12/24.
//

import Foundation

/// Clase la cual representa las propiedades de un personaje de DragonBall
class CharacterDBZ: Codable {
    let id: Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let originPlanet: Planet?
    let transformations: [Transformation]?
}

/// Clase la cual representa una transformación en algun personaje en caso de tener.
class Transformation: Codable {
    let id: Int
    let name: String
    let image: String
    let ki: String
}
