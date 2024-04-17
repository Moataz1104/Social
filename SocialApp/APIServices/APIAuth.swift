//
//  APIAuth.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 05/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginResponse: Codable {
    let message: String
    let token: String
}


class APIAuth {
    static let shared = APIAuth()
    private init(){}
    
    let errorPublisher = PublishRelay<Error>()
    
    
    func logInUser(email: String, password: String){
        let body = [
            "email": email,
            "password": password
        ]
        baseRequest(url: apiK.logInURL!, body: body) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print("Request successful. Response data: \(data)")
                    do {
                        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                        print("Request successful. Response data: \(response)")
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
            "userName":userName,
            "email": email,
            "password": password
        ]
        baseRequest(url: apiK.registerURL!, body: body) {[weak self] result in
            switch result{
            case .success(let data):
                if let data = data{
                    print("Request successful. Response data: \(data)")
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                self?.errorPublisher.accept(error)
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    private func baseRequest(url:URL,body:[String:String],completion: @escaping (Result<Data?,Error>) ->Void){
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = jsonData
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 0)))
                return
            }
            if (200..<300).contains(httpResponse.statusCode) {
                completion(.success(data))
            }else{
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode)))
            }
        }
        .resume()

    }
    
    
    
}
