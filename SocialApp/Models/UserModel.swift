//
//  UserModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 29/04/2024.
//

import Foundation


struct UserModel: Codable {
    let id, name, userName, email: String?
    let followers, following: [Int]?
    let role, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, userName, email,followers, following, role, createdAt, updatedAt
    }
}
