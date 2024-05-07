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

    
    init(coordinator: HomeCoordinator,disposeBag:DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
    }
    
}
