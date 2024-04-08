//
//  ProfileCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import Foundation
import UIKit

class ProfileCoordinator:Coordinator{
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vc = ProfileView()
        navigationController.pushViewController(vc, animated: true)

    }
    
    
}
