//
//  CommentViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 05/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

class CommentViewModel{
    let postID : String
    let disposeBag:DisposeBag
    var commentData : CommentModel?
    var reloadDataClosure: (() -> Void)?
    
    init(postID: String,disposeBag:DisposeBag) {
        self.postID = postID
        self.disposeBag = disposeBag
        subscribeToCommentsDataPublosher()
        getAllComments()
    }
    
//    MARK: - API Subscribtion
    
    private func subscribeToCommentsDataPublosher(){
        APIPostInteractions.shared.commentsDataPublisher
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.commentData = result
                self?.reloadDataClosure?()
            })
            .disposed(by: disposeBag)
    }
        
    private func getAllComments(){
        APIPostInteractions.shared.getAllComments(postId: postID, accessToken: APIAuth.shared.accessToken)
    }
    
}
