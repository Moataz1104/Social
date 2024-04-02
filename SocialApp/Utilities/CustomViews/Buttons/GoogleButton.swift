//
//  FaceBookButton.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class GoogleButton: SocialMediaButtons {
    override func setupButton() {
        super.setupButton()
        setImage(UIImage(named: "googleLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        title = "Log In With Google"
    }
}
