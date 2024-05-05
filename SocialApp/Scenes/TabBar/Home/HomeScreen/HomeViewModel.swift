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
    let likeButtonSubject = PublishRelay<Void>()
    let commentButtonSubject = PublishRelay<Void>()

    
    var postId = ""
    
    var posts = [Datum]()
    
    var reloadDataClosure: (() -> Void)?
    
    
    
    init(coordinator: HomeCoordinator,disposeBag:DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
        
        subscribeToPostButton()
        subscribeToErrorPublisher()
        subscribeToGetPostsPublisher()
        subscribeToLikeButton()
        subscribeToCommentButton()
        
        getAllPosts()
        
    }
    
    
    
//    MARK: - Add Post Cell subscribers
    
  
    
    private func subscribeToPostButton(){
        postButtonSubject
            .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(addPostContentSubject)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] content in
                guard let self = self else { return }
                APIPosts.shared.addPost(content: content, accessToken: APIAuth.shared.accessToken)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.getAllPosts()
                }
                
                print(APIAuth.shared.accessToken)
                
                
            })
            .disposed(by: disposeBag)
    }
    

//    MARK: - Post Cell subscribers

    private func subscribeToLikeButton(){
        likeButtonSubject
            .subscribe {[weak self] _ in
                guard let self = self else {return}
                APIPostInteractions.shared.addLikeToPost(postId: self.postId, accessToken: APIAuth.shared.accessToken)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.getAllPosts()
                }
            }
            .disposed(by: disposeBag)

    }
    private func subscribeToCommentButton(){
        commentButtonSubject
            .subscribe {[weak self] _ in
                guard let self = self else {return}
                self.showCommentsScreen(postID: self.postId)
                
            }
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
    
    func showCommentsScreen(postID:String){
        coordinator?.showCommentScreen(postId: postID)
    }
    
    
    
    


}
