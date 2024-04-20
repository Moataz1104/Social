//
//  HomeViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 12/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel{
    
    weak var coordinator : HomeCoordinator?
    let disposeBag : DisposeBag
    
    let addPostContentSubject = PublishSubject<String>()
    let postButtonSubject = PublishRelay<Void>()

    var postContent = ""
    
    init(coordinator: HomeCoordinator,disposeBag:DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
        
        subscribeToPostButton()
        subscribeToPostContent()
    }
    
    
    private func subscribeToPostButton(){
        postButtonSubject
            .do(onNext: { _ in
                print(self.postContent)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func subscribeToPostContent(){
        addPostContentSubject
            .subscribe { content in
                self.postContent = content
            }
            .disposed(by: disposeBag)
            
    }
    
    
    
    func showCommentsScreen(){
        coordinator?.showCommentScreen()
    }
}
