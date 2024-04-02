//
//  SocialMediaButtons.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class SocialMediaButtons: UIButton {

    var title: String? {
        get { titleLabel?.text }
        set { setTitle("  " + (newValue ?? ""), for: .normal) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(.B_500, for: .normal)
        heightAnchor.constraint(equalToConstant: 45).isActive = true
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .W_300).cgColor
    }
}
