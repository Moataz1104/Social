//
//  AuthModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 17/04/2024.
//

import Foundation


struct LoginResponse: Codable {
    let message: String
    let accessToken: String
}

struct SignupResponse: Codable {
    let message: String
//    let data: UserData
}

//struct UserData: Codable {
//    let name: String
//    let userName: String
//    let email: String
//    let active: Bool
//    let password: String
//    let confirmEmail: Bool
//    let followers: [String]
//    let following: [String]
//    let role: String
//    let id: String
//    let createdAt: String
//    let updatedAt: String
//    let v: Int
//
//    enum CodingKeys: String, CodingKey {
//        case name, userName, email, active, password, confirmEmail, followers, following, role
//        case id = "_id"
//        case createdAt, updatedAt
//        case v = "__v"
//    }
//}

