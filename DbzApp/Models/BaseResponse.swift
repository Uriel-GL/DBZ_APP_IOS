//
//  BaseResponse.swift
//  DbzApp
//
//  Created by Uriel GL on 03/12/24.
//

import Foundation

/// Clase la cual representara la respuesta base de la API de DragonBall
class BaseResponse<T: Codable>: Codable {
    let items: T
    let meta: Meta
    let links: Links
}


/// Clase la cual representa la data del servicio (número de paginas, número de items por pagina, etc.)
class Meta: Codable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

/// Clase la cual representa los links de navegación
class Links: Codable {
    let first: String
    let previous: String?
    let next: String
    let last: String
}
