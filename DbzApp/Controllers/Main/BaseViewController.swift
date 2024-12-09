//
//  BaseViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 16/10/24.
//

import UIKit

/// Controlador en el cual se configura un NavBar base para los demas controladores en la App
class BaseViewController: UIViewController {

    var loaderView: UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = DBZAppColors.primary.color
        activity.style = .large
        return activity
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Boton back personalizado
        let backButton = UIBarButtonItem()
        backButton.title = "Atras"
        backButton.tintColor = DBZAppColors.primary.color
        self.navigationItem.backBarButtonItem = backButton
        
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
        
        //Configuración de ActivityIndicator
//        self.view.addSubview(self.loaderView)
//        NSLayoutConstraint.activate([
//            self.loaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.loaderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//        ])
    }
    
    //MARK: - Funciones de los botones del NavBar
    @objc func openSettings() {
        //Funcion a ejecutar
    }
    
    @objc func openNotifications() {
        //Funcion a ejecutar
    }
    
    /// Variable la cual nos ayudara a controlar el funcionamiento del ActivityIndicate
//    var isLoaderActive: Bool = false {
//        didSet {
//            if self.isLoaderActive {
//                self.loaderView.startAnimating()
//                self.loaderView.isHidden = false
//            } else {
//                self.loaderView.stopAnimating()
//                self.loaderView.isHidden = true
//            }
//        }
//    }
}
