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
    
    case getAllCharacters(numPage: Int = 1, completion: (Result<BaseResponse<[CharacterDBZ]>, Error>) -> Void)
    case getAllPlanets(numPage: Int = 1, completion: (Result<BaseResponse<[Planet]>, Error>) -> Void)
    case getPlanet(id: Int, completion: (Result<Planet, Error>) -> Void)
    case getCharacter(id: Int, completion: (Result<CharacterDBZ, Error>) -> Void)
    
    // Esta variable nos ppermitira modificar los endpoints de una manera mas dinamica
    private var url: String {
        switch self {
        case .getAllCharacters(let numPage, _):
            return "\(API.baseUrl)/characters?page=\(numPage)&limit=10"
        case .getAllPlanets(let numPage, _):
            return "\(API.baseUrl)/planets?page=\(numPage)&limit=10"
        case .getPlanet(let id, _):
            return "\(API.baseUrl)/planets/\(id)"
        case .getCharacter(let id, _):
            return "\(API.baseUrl)/characters/\(id)"
        }
    }
    
    // Esta varibale mos permitira obtener el tipo de HTTPMethod dinamico dependiendo del EndPoint a utilizar
    private var method: HTTPMethod {
        switch self {
        case .getAllCharacters, .getAllPlanets, .getPlanet, .getCharacter:
            return .get
        }
    }
    
    func excecute() {
        AF.request(self.url, method: self.method).validate().responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(_):
                guard let data = dataResponse.value  else { return }
                do {
                    switch self {
                    case .getAllCharacters(_, let completion):
                        let response = try JSONDecoder().decode(BaseResponse<[CharacterDBZ]>.self, from: data)
                        completion(.success(response))
                    case .getAllPlanets(_, let completion):
                        let response = try JSONDecoder().decode(BaseResponse<[Planet]>.self, from: data)
                        completion(.success(response))
                    case .getPlanet(_, let completion):
                        let response = try JSONDecoder().decode(Planet.self, from: data)
                        completion(.success(response))
                    case .getCharacter(_, let completion):
                        let response = try JSONDecoder().decode(CharacterDBZ.self, from: data)
                        completion(.success(response))
                    }
                } catch {
                    debugPrint("Ocurrio un error \(error)")
                    handleCompletionWithError(error: error)
                }
            case .failure(let error):
                debugPrint("API ERROR: \(error)")
                handleRequestWithError(error: error)
            }
        }
    }
    
    func handleCompletionWithError(error: Error) {
        switch self {
        case .getAllCharacters(_, let completion):
            completion(.failure(error))
        case .getAllPlanets(_, let completion):
            completion(.failure(error))
        case .getPlanet(_, let completion):
            completion(.failure(error))
        case .getCharacter(_, let completion):
            completion(.failure(error))
        }
    }
    
    func handleRequestWithError(error: Error) {
        debugPrint("Api error: \(error)")
        
        if let errorDesc = error.asAFError?.underlyingError as? NSError {
            switch errorDesc.code {
            case NSURLErrorNotConnectedToInternet:
                showAlert(message: "No estás conectado a internet. Por favor, revisa la configuración de tu red.")
            case NSURLErrorTimedOut:
                showAlert(message: "El tiempo de espera para la solicitud se agotó. Inténtalo de nuevo.")
            default:
                debugPrint("Error aun no manejado: \(errorDesc.code)")
            }
        } else {
            handleCompletionWithError(error: error)
        }
    }
    
    private func showAlert(message: String) {
        guard let topController = getTopViewController() else { return }
        let alert = UIAlertController(title: "Sin Conexión", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: .default))
        topController.present(alert, animated: true, completion: nil)
    }
    
    private func getTopViewController() -> UIViewController? {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return scene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        }
        return nil
    }
}
