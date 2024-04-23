//
//  APIAddPost.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 20/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

class APIAddPost {
    static let shared = APIAddPost()
    private init(){}
    
    let errorPublisher = PublishRelay<Error>()
    let resultDataPublisher = PublishSubject<Any>()

    
    func addPost(content:String, accessToken : String){
        print("request add post sent")
        let body = [
            "content" : content,
            "token" : accessToken
        ]
        
        APIRequest.baseRequest(url: apiK.addPostURL!, body: body) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print(data)
                    self?.resultDataPublisher.onNext(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.errorPublisher.accept(error)
            }
        }
    }
    
}
