//
//  APIAddPost.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 20/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

class APIPosts {
    static let shared = APIPosts()
    private init(){}
    
    let errorPublisher = PublishRelay<Error>()
    let resultDataPublisher = PublishSubject<Any>()

    
    func addPost(content:String, accessToken : String){
        print("request add post sent")
        let body = [
            "content" : content
        ]
        
        var request = URLRequest(url: apiK.addGetPostURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData
        
        APIRequests.baseRequest(request:request, body: body) {[weak self] result in
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
    
    func getAllPosts(accessToken:String){
        
        var request = URLRequest(url: apiK.addGetPostURL!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        APIRequests.baseRequest(request:request, body: nil) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print("posts data \(data)")
                    self?.resultDataPublisher.onNext(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.errorPublisher.accept(error)
            }
        }
    }
    
}
