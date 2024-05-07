//
//  UserProfileDetailsCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 14/04/2024.
//

import UIKit


protocol MyProfileDetailsCellDelegate: AnyObject {
    func tabBarItemSelected(tag: Int)
}

class MyProfileDetailsCell: UICollectionViewCell {
    static let identifier = "MyProfileDetailsCell"
    weak var delegate:MyProfileDetailsCellDelegate?
    
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var tabBar:UITabBar!
    @IBOutlet weak var myPostsTabBarItem:UITabBarItem!
    @IBOutlet weak var settingTabBarItem:UITabBarItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        tabBar.selectedItem = myPostsTabBarItem
        tabBar.delegate = self
        
        addObserverForSelectedImage()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    MARK: - Selected image observer
    
    func addObserverForSelectedImage(){
        NotificationCenter.default.addObserver(self, selector: #selector(selectedImageDidChange), name: .selectedImageDidChangeNotification, object: nil)
        
    }
    
    @objc private func selectedImageDidChange() {
        updateUI()
    }
    
    private func updateUI() {
        if let image = ImageSelectionManager.shared.selectedImage {
            userImage.image = image
            userImage.contentMode = .scaleAspectFill
        }
    }
}





extension MyProfileDetailsCell: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        delegate?.tabBarItemSelected(tag: item.tag)
    }
}

