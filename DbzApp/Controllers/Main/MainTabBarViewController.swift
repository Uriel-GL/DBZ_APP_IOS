//
//  MainTabBarViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 28/10/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Controladores
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let planetasVC = UINavigationController(rootViewController: PlanetasViewController())
        
        //Configuración del tabBar en cada controlador
        homeVC.tabBarItem = UITabBarItem(title: "Personajes", image: UIImage(systemName: "house")?.withTintColor(UIColor.systemBackground), tag: 0)
        planetasVC.tabBarItem = UITabBarItem(title: "Planetas", image: UIImage(systemName: "globe.americas")?.withTintColor(UIColor.systemBackground), tag: 1)
        
        //Asigancion de los controladores al tabBar
        self.viewControllers = [
            homeVC,
            planetasVC
        ]
        
        self.tabBar.tintColor = DBZAppColors.primary.color
        self.tabBar.backgroundColor = UIColor.systemBackground
        self.selectedIndex = 0
    }
}
