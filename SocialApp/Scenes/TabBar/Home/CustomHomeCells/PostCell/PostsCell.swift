//
//  PostCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 09/04/2024.
//

import UIKit

protocol PostsCellDelgate:AnyObject{
    func postCellHeightDidChange(_ height:CGFloat,at indexPath: IndexPath)
}

class PostsCell: UICollectionViewCell {
    static let identifier = "PostCell"
    
    var isThisMyPost = false
    
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userNickName:UILabel!
    @IBOutlet weak var postContent:UILabel!
    @IBOutlet weak var likeButtonOutlet:UIButton!
    @IBOutlet weak var numberOfLikes:UILabel!
    @IBOutlet weak var postTime:UILabel!
    
    var viewModel : HomeViewModel?
    var indexPath: IndexPath?
    weak var delegate : PostsCellDelgate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        getPostCellHeight()
    }
    
    @IBAction func commentButtonAction(_ sender: Any) {
        viewModel?.showCommentsScreen()
    }
    

    
    func getPostCellHeight(){
        let maxSize = CGSize(width: postContent.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let totalHeight = postContent.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: postContent.font ?? UIFont.systemFont(ofSize: 16)], context: nil).height ?? 0

        if let indexPath = indexPath {
            delegate?.postCellHeightDidChange(totalHeight + 200, at: indexPath)
        }
        
    }
    

}
