//
//  SignUpViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation

class SignUpViewModel {
    weak var coordinator : AuthCoordinator?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    
    
    func popBack(){
        coordinator?.popVC()
    }
}
