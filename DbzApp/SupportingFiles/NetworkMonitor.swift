//
//  NetworkMonitor.swift
//  DbzApp
//
//  Created by Uriel GL on 07/11/24.
//

import Foundation
import Network
import UIKit

/// Clase la cual nos ayudara a detectar si el dispositivo cuenta con conexión a internet
class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    var isConnected: Bool = true
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            if !self!.isConnected {
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        guard let topController = getTopViewController() else { return }
        let alert = UIAlertController(title: "Sin Conexión", message: "No estás conectado a internet. Por favor, revisa la configuración de tu red.", preferredStyle: .alert)
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
