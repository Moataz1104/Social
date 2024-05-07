//
//  UsersDetailsCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/05/2024.
//

import UIKit

class UsersDetailsCell: UICollectionViewCell {
    
    static let identifier = "UsersDetailsCell"
    
    @IBOutlet weak var followButtonOutlet: UIButton!
    @IBOutlet weak var messageButtonOutlet: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configUi()
    }
    
    
    private func configUi(){
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        
        followButtonOutlet.layer.cornerRadius = 7
        messageButtonOutlet.layer.cornerRadius = 7
        
    }
    
}
