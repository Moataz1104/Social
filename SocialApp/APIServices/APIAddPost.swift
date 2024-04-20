//
//  APIAddPost.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 20/04/2024.
//

import Foundation

class APIAddPost {
    static let shared = APIAddPost()
    private init(){}
    
    
    
    func addPost(content:String, accessToken : String){
        print("request add post sent")
        let body = [
            "content" : content,
            "token" : accessToken
        ]
        
        APIRequest.baseRequest(url: apiK.addPostURL!, body: body) { result in
            switch result{
            case .success(let data):
                if let data = data{
                    print(data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
