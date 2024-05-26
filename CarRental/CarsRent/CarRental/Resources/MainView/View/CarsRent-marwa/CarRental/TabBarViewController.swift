//
//  TabBarViewController.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 25/03/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    private func configureTabs() {
        let vc1 = MainViewController()
        let vc2 = ChatsViewController()
        let vc3 = ProfileViewController()
        
        //set tab images
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "message.badge")
        vc3.tabBarItem.image = UIImage(systemName: "person")
        
  
        vc1.title = "Main"
        vc3.title = "Profile"
        vc2.title = "Chats"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 14)]
            
            
        
    
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray2
        
        let navController1 = UINavigationController(rootViewController: vc1)
        let navController2 = UINavigationController(rootViewController: vc2)
        let navController3 = UINavigationController(rootViewController: vc3)
        
        self.setViewControllers([navController1, navController3, navController2], animated: false)
    }

}
