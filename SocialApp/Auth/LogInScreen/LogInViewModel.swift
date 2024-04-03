//
//  LogInViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation

class LogInViewModel {
    weak var coordinator : AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    
    func signUpButtonTap(){
        coordinator?.showSignUpScreen()
    }
}
