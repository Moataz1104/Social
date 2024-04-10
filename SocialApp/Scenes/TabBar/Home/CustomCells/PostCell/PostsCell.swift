//
//  PostCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 09/04/2024.
//

import UIKit

class PostsCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userNickName:UILabel!
    @IBOutlet weak var postContent:UILabel!
    @IBOutlet weak var likeButtonOutlet:UIButton!
    @IBOutlet weak var numberOfLikes:UILabel!
    @IBOutlet weak var postTime:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
    }

}
