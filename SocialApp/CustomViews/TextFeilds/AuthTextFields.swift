//
//  AuthTextFields.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class AuthTextFields: UITextField {

    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        
        setUpTextFields()
    }
    
    func setUpTextFields(){
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .W_300).cgColor
    }
}
