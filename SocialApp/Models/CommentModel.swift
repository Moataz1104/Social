//
//  CommentModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 05/05/2024.
//

import Foundation

struct CommentModel:Codable{
    
    let message: String?
    let result: Int?
    let data: [CommentDetails]?
}
struct CommentDetails: Codable {
    let id, content, user, post: String?
    let createdAt, updatedAt: String?
    
}


