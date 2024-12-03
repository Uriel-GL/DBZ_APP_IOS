//
//  BbzTabBarViewController.swift
//  DbzApp
//
//  Created by Uriel GL on 30/10/24.
//

import UIKit

class DBZTabBarViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    
    let tabBar: MainTabBarViewController
    
    init() {
        tabBar = MainTabBarViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.view.frame = viewContainer.bounds
        self.tabBar.view.backgroundColor = UIColor.white
        self.addChild(tabBar)
        self.tabBar.willMove(toParent: self)
        self.viewContainer.addSubview(self.tabBar.view)
        self.tabBar.didMove(toParent: self)
        self.navigationController?.navigationBar.isHidden = true
    }
}
