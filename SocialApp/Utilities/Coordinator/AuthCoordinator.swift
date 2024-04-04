//
//  AuthCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation
import UIKit
import RxSwift

class AuthCoordinator : Coordinator{
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogInScreen()
    }
    
    
    func popVC(){
        navigationController.popViewController(animated: true)
    }
    
    
    func showLogInScreen(){
        let viewModel = LogInViewModel(coordinator: self)
        let vc = LogInView(viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: true)
    }

    
    func showSignUpScreen(){
        let disposeBag = DisposeBag()
        let viewModel = SignUpViewModel(coordinator: self, disposeBage: disposeBag)
        let vc = SignUpView(viewModel: viewModel, disposeBage: disposeBag)
        navigationController.pushViewController(vc, animated: true)
    }

}
