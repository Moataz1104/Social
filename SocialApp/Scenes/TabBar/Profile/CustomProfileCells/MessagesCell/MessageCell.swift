//
//  MessageCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 17/04/2024.
//

import UIKit

class MessageCell: UITableViewCell {
    static let identifier = "MessageCell"

    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
