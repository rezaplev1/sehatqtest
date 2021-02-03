//
//  MainViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.view.backgroundColor = .white
        setupTabbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.setHidesBackButton(true, animated: true)

    }
   
    @objc func setupTabbar() {
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.isNavigationBarHidden = true
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTabbar"), tag: 0)
        
        let feedVC = FeedViewController()
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.isNavigationBarHidden = true
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "categoryTabbar"), tag: 1)
        
        let cartVC = CartViewController()
        let cartNav = UINavigationController(rootViewController: cartVC)
        cartNav.isNavigationBarHidden = true
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cartTabbar"), tag: 2)
        
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.isNavigationBarHidden = true
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profileTabbar"), tag: 3)
        
        self.viewControllers = [homeNav, feedNav, cartNav, profileNav]
        tabBar.isTranslucent = false
    }
    
}

    

