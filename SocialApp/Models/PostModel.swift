//
//  PostModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 29/04/2024.
//

import Foundation

import Foundation

struct PostModel: Codable {
    let message: String?
    let data: [Datum]?
}

struct Datum: Codable {
    let id, content: String?
    let images: [String]?
    let createdBy: UserModel?
    let commentsCount, likesCount: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case content, images, createdBy, commentsCount, likesCount, createdAt, updatedAt
    }
}
