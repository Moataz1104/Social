//
//  AuthCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation
import UIKit
import RxSwift

protocol AuthCoordinatorDelegate: AnyObject {
    func didLoginSuccessfully()
}


class AuthCoordinator : Coordinator{
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    weak var delegate: AuthCoordinatorDelegate?

    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogInScreen()
    }
    
    
    func popVC(){
        DispatchQueue.main.async {[weak self] in
            self?.navigationController.popViewController(animated: true)
        }
    }
    
    
    func showLogInScreen(){
        let disposeBag = DisposeBag()
        let viewModel = LogInViewModel(coordinator: self, disposeBag: disposeBag)
        let vc = LogInView(viewModel: viewModel, disposeBag: disposeBag)
        
        navigationController.pushViewController(vc, animated: true)
    }

    
    func showSignUpScreen(){
        let disposeBag = DisposeBag()
        let viewModel = SignUpViewModel(coordinator: self, disposeBage: disposeBag)
        let vc = SignUpView(viewModel: viewModel, disposeBage: disposeBag)
        navigationController.pushViewController(vc, animated: true)
    }

}
