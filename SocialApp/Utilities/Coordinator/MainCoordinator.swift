//
//  MainCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    var isLogin = true
    
    func start() {
        if isLogin{
            showTabBar()
        }else{
            showAuth()
        }
    }
    
    func showAuth(){
        let childCoordinator = AuthCoordinator(navigationController: navigationController)
        
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
    
    func showTabBar(){
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.backgroundColor = .white

        let tab1Coordinator = HomeCoordinator(navigationController: UINavigationController())
        let tab2Coordinator = SearchCoordinator(navigationController: UINavigationController())
        let tab3Coordinator = NotificationCoordinator(navigationController: UINavigationController())
        let tab4Coordinator = ProfileCoordinator(navigationController: UINavigationController())

        childCoordinators.append(contentsOf: [tab1Coordinator as Coordinator, tab2Coordinator as Coordinator, tab3Coordinator as Coordinator, tab4Coordinator as Coordinator])

        tab1Coordinator.start()
        tab2Coordinator.start()
        tab3Coordinator.start()
        tab4Coordinator.start()

        tabBarController.viewControllers = [tab1Coordinator.navigationController,
                                             tab2Coordinator.navigationController,
                                             tab3Coordinator.navigationController,
                                             tab4Coordinator.navigationController]
        
        if let items = tabBarController.tabBar.items{
            items[0].image = UIImage(systemName: "house.fill")
            items[1].image = UIImage(systemName: "magnifyingglass")
            items[2].image = UIImage(systemName: "bell")
            items[3].image = UIImage(systemName: "person")

        }
        

        navigationController.setViewControllers([tabBarController], animated: true)

    }
    
        
}
