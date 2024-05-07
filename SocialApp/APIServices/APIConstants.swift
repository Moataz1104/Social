//
//  APIConstants.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 05/04/2024.
//

import Foundation

struct apiK{
    static let logInURL =
    URL(string: "https://social-app-api-944j.onrender.com/api/v1/auth/login")
    
    static let registerURL =
    URL(string: "https://social-app-api-944j.onrender.com/api/v1/auth/signup")
    
    static let forgetPwURL = URL(string: "")
    
    static let addGetPostURL =
    URL(string: "https://social-app-api-944j.onrender.com/api/v1/post?limit=250")
    
    static let postInteractionsURL =
    URL(string:"https://social-app-api-944j.onrender.com/api/v1/post")
    
    static let getUserURL = URL(string: "https://social-app-api-944j.onrender.com/api/v1/user")
    
}

/*
 Any user has to be activated
 activated account:
 email: moataz.mohamed.id@gmail.com
 PW : 12345678
 */
