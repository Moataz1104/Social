//
//  HomeCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import Foundation
import UIKit

class HomeCoordinator:Coordinator{
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let vc = HomeView(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCommentScreen(){
        let vc = CommentsView()
        let newNavController = UINavigationController(rootViewController: vc)
        newNavController.modalPresentationStyle = .pageSheet
        navigationController.present(newNavController, animated: true, completion: nil)

    }
    
    
}
