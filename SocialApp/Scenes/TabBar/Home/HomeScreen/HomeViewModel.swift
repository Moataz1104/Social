//
//  HomeViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 12/04/2024.
//

import Foundation

class HomeViewModel{
    
    weak var coordinator : HomeCoordinator?

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    
    
    func showCommentsScreen(){
        coordinator?.showCommentScreen()
    }
}
