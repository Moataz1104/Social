//
//  APIAuth.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 05/04/2024.
//

import Foundation
import RxSwift
import RxCocoa



class APIAuth {
    static let shared = APIAuth()
    private init(){}
    
    let errorPublisher = PublishRelay<Error>()
    let resultDataPublisher = PublishSubject<Any>()
    
    var accessToken = ""
    
    func logInUser(email: String, password: String){
        let body = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: apiK.logInURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData

        APIRequests.baseSession( request: request, body: body) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print("Request successful. Response data: \(data)")
                    do {
                        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                        print("Request successful. Response data: \(response)")
                        self?.resultDataPublisher.onNext(response)
                        self?.accessToken = response.accessToken
                    } catch {
                        print("Error decoding response: \(error)")
                        self?.errorPublisher.accept(error)
                    }
                    
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                self?.errorPublisher.accept(error)
            }
        }
    }
    
    func registerUser(userName:String,email: String, password: String){
        print("Request sent")
        let body = [
            "name":userName,
            "userName":userName,
            "email": email,
            "password": password,
            "confirmPassword":password
        ]
        var request = URLRequest(url: apiK.logInURL!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData

        APIRequests.baseSession(request:request, body: body) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print("Request successful. Response data: \(data)")
                    do {
                        let response = try JSONDecoder().decode(SignupResponse.self, from: data)
                        print("Request successful. Response data: \(response)")
                        self?.resultDataPublisher.onNext(response)
                    } catch {
                        print("Error decoding response: \(error)")
                        self?.errorPublisher.accept(error)
                    }
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                self?.errorPublisher.accept(error)
            }
        }
    }

    
    
    
}
