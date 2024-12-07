//
//  BaseViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 16/10/24.
//

import UIKit

/// Controlador en el cual se configura un NavBar base para los demas controladores en la App
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configuracion del navigation NavBar
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(openSettings))
        settingsButton.tintColor = UIColor.black
        
        let notiButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(openNotifications))
        notiButton.tintColor = UIColor.black
        
        var titleView: UIView? {
            let imageView = UIImageView(image: UIImage(named: "banner"))
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            return imageView
        }
        
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem = settingsButton
        self.navigationItem.rightBarButtonItem = notiButton
    }
    
    //MARK: - Funciones de los botones del NavBar
    @objc func openSettings() {
        //Funcion a ejecutar
    }
    
    @objc func openNotifications() {
        //Funcion a ejecutar
    }

}
