//
//  MainButton.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class MainButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton(){
        setTitleColor(.white, for: .normal)
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        backgroundColor = .B_900
        layer.cornerRadius = 4

    }

}
