//
//  APIRequest.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 20/04/2024.
//

import Foundation

struct APIRequest{
    static func baseRequest(url:URL,body:[String:String],completion: @escaping (Result<Data?,Error>) ->Void){
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
                return
            }else{
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode)))
                return
            }
        }
        .resume()
        
    }
    
    

}
