//
//  APIPostInteractions.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

class APIPostInteractions{
    static let shared = APIPostInteractions()
    private init(){}
    
    let commentsDataPublisher = PublishRelay<CommentModel>()
    
    func addLikeToPost(postId:String,accessToken:String){
        let postInteractionsURL = apiK.postInteractionsURL!
        var urlComponents = URLComponents(url: postInteractionsURL, resolvingAgainstBaseURL: false)
        urlComponents?.path.append("/\(postId)/like")
        let url = urlComponents?.url
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        print(url!)
        APIRequests.baseSession(request:request, body: nil) {[weak self] result in
            guard let _ = self else{return}
            switch result{
            case .success(let data):
                if let data = data{
                    print(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
//                self?.errorPublisher.accept(error)
            }
        }

    }
    
    
    func getAllComments(postId:String,accessToken:String){
        let postInteractionsURL = apiK.postInteractionsURL!
        var urlComponents = URLComponents(url: postInteractionsURL, resolvingAgainstBaseURL: false)
        urlComponents?.path.append("/\(postId)/comment")
        let url = urlComponents?.url
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        APIRequests.baseSession(request:request, body: nil) {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let data):
                if let data = data{
                    do{
                        let decodedData = try JSONDecoder().decode(CommentModel.self, from: data)
                        self.commentsDataPublisher.accept(decodedData)
                        
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }

    }
    

}
