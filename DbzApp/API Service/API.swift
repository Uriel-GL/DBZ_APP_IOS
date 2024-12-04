//
//  API.swift
//  DbzApp
//
//  Created by Uriel GL on 21/10/24.
//

import Foundation
import Alamofire

// Enum el cual contendra los EndPoints del servicio de DragonBallApi
enum API {
    private static var baseUrl: String = "https://dragonball-api.com/api"
    
    //Se setea 1 ya que sera la consulta por defecto en caso de que no se establezca el número de pagina
    case getAllCharacters(numPage: Int = 1, completion: (Result<BaseResponse<[CharacterDBZ]>, Error>) -> Void)
    
    // Esta variable nos ppermitira modificar los endpoints de una manera mas dinamica
    private var url: String {
        switch self {
        case .getAllCharacters(let numPage, _):
            return "\(API.baseUrl)/characters?page=\(numPage)&limit=10"
        }
    }
    
    // Esta varibale mos permitira obtener el tipo de HTTPMethod dinamico dependiendo del EndPoint a utilizar
    private var method: HTTPMethod {
        switch self {
        case .getAllCharacters:
            return .get
        }
    }
    
    func excecute() {
//        debugPrint("host: \(self.url) - Metodo: \(self.method)")
        AF.request(self.url, method: self.method).validate().responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(_):
                guard let data = dataResponse.value  else { return }
//                debugPrint(String(data: data, encoding: .utf8) ?? "-")
                do {
                    switch self {
                    case .getAllCharacters(_, let completion):
                        let response = try JSONDecoder().decode(BaseResponse<[CharacterDBZ]>.self, from: data)
                        completion(.success(response))
                    }
                } catch {
                    debugPrint("Ocurrio un error \(error)")
                    switch self {
                    case .getAllCharacters(_, let completion):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                debugPrint("API ERROR: \(error)")
            }
        }
    }
}
