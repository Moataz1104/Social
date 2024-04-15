//
//  AddUserInfoCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 15/04/2024.
//

import UIKit

class AddUserInfoCell: UICollectionViewCell {
    static let identifier = "AddUserInfoCell"
    
    @IBOutlet weak var chooseImage : UIImageView!
    @IBOutlet weak var userName : UITextField!
    @IBOutlet weak var userBio : UITextField!
    @IBOutlet weak var saveButton:UIButton!
    @IBOutlet weak var logOutButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        
    }
    
    
    
    private func configUI(){
        chooseImage.layer.borderWidth = 1
        chooseImage.layer.cornerRadius = chooseImage.bounds.width / 2
        chooseImage.clipsToBounds = true
        
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 2
        
        
    }
    
}
