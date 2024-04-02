//
//  EmailButton.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class EmailButton : SocialMediaButtons {
    override func setupButton() {
        super.setupButton()
        setImage(UIImage(named: "emailLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        title = "Log In With Email"        
    }
}
