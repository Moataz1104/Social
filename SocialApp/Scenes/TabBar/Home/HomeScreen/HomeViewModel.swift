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
    let errorSubjectMessage = PublishSubject<String>()

    
    var posts = [Datum]()
    
    var reloadDataClosure: (() -> Void)?
    
    
    
    init(coordinator: HomeCoordinator,disposeBag:DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
        
        subscribeToPostButton()
        subscribeToErrorPublisher()
        subscribeToGetPostsPublisher()
        
        getAllPosts()
        
        
    }
    
    
    
//    MARK: - View subscribers
    
  
    
    private func subscribeToPostButton(){
        postButtonSubject
            .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(addPostContentSubject)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] content in
                guard let self = self else { return }
                APIPosts.shared.addPost(content: content, accessToken: APIAuth.shared.accessToken)
                self.getAllPosts()
                self.reloadDataClosure?()
                
                print(content)
                
                
            })
            .disposed(by: disposeBag)
    }
    

    

    
    //    MARK: - API subscribers
    
    
    private func subscribeToGetPostsPublisher(){
        APIPosts.shared.getPostsResultPublisher
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] event in
                if let result = event.event.element as? PostModel{
                    if result.message == "success"{
                        if let data = result.data{
                            self?.posts = data.reversed()
                            self?.reloadDataClosure?()
                            
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func subscribeToAddPostsResultPublisher(){
        APIPosts.shared.addPostResultPublisher
            .subscribe { event in
                
            }
            .disposed(by: disposeBag)
    }
    
    
    
    private func subscribeToErrorPublisher(){
        APIPosts.shared.errorPublisher
            .subscribe {[weak self] event in
                print(event.event.element?.localizedDescription ?? "")
                self?.errorSubjectMessage.onNext(event.element?.localizedDescription ?? "No Description")

            }
            .disposed(by: disposeBag)
    }

    
    func getAllPosts(){
        APIPosts.shared.getAllPosts(accessToken: APIAuth.shared.accessToken)
    }
    
    
    
    
    
//    Navigation
    
    func showCommentsScreen(){
        coordinator?.showCommentScreen()
    }
    
    
    
    


}
