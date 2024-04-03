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
    
    var isLogin = false
    
    func start() {
        if isLogin{
            
        }else{
            showAuth()
        }
    }
    
    func showAuth(){
        let childCoordinator = AuthCoordinator(navigationController: navigationController)
        
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
    
        
}
