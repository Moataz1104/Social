//
//  UsersViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

class UsersViewModel{
    weak var coordinator : HomeCoordinator?
    let disposeBag : DisposeBag
    let userId : String
    var user : UserModel?

    
    init(coordinator: HomeCoordinator,disposeBag:DisposeBag,userId:String) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
        self.userId = userId
        
        subcribeToUserDataPublisher()
        
        getUser()
    }
    
    
    func getUser(){
        APIUsers.shared.getUser(userId: userId)
    }
    
    func subcribeToUserDataPublisher(){
        APIUsers.shared.userDataPublisher
            .subscribe {[weak self] user in
                self?.user = user
            }
            .disposed(by: disposeBag)
    }
}
