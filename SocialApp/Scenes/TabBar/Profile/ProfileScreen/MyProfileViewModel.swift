//
//  ProfileViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 17/04/2024.
//

import Foundation

class MyProfileViewModel{
    weak var coordinator : ProfileCoordinator?
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }
    
    func showMessagesScreen(){
        coordinator?.showMessagesScreen()
    }
}
