//
//  APIUsers.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

class APIUsers{
    static let shared = APIUsers()
    private init(){}
    
    let userDataPublisher = PublishRelay<UserModel>()
    
    
    func getUser(userId:String){ // just wait to be completed from the backend
        let getUserUrl = apiK.getUserURL!
        var urlComponents = URLComponents(url: getUserUrl, resolvingAgainstBaseURL: false)
        urlComponents?.path.append("/\(userId)")
        let url = urlComponents?.url
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        APIRequests.baseSession(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                print("get user success")
                if let data = data {
                    do{
                        let decodedData = try JSONDecoder().decode(UserModel.self, from: data)
                        self?.userDataPublisher.accept(decodedData)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

        
    }
    
    
    
    
}
