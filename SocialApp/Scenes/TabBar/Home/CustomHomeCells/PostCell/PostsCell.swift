//
//  PostCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 09/04/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol PostsCellHeightDelgate:AnyObject{
    func postCellHeightDidChange(_ height:CGFloat,at indexPath: IndexPath)
}

protocol PostsCellDelegate: AnyObject {
    func postCellDidLike(_ postId: String)
    func postCellDidPressComment(_ postId: String)

}


class PostsCell: UICollectionViewCell {
    static let identifier = "PostCell"
        
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userNickName:UILabel!
    @IBOutlet weak var postContent:UILabel!
    @IBOutlet weak var likeButtonOutlet:UIButton!
    @IBOutlet weak var numberOfLikes:UILabel!
    @IBOutlet weak var postTime:UILabel!
    
    var viewModel : HomeViewModel?
    var indexPath: IndexPath?

    weak var delegate : PostsCellHeightDelgate?
    weak var postDelegate: PostsCellDelegate?

    
//    MARK: - Cell Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        
        addTapGestureToImage()

    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
//    MARK: - Actions
    
    @IBAction func commentButtonAction(_ sender: Any) {
        postDelegate?.postCellDidPressComment(postId)
        
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        postDelegate?.postCellDidLike(postId)
    }
    
    private func addTapGestureToImage(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapGesture(_:)))
        userImage.addGestureRecognizer(tapGesture)
    }
    @objc func imageTapGesture(_ sender: UITapGestureRecognizer) {
        viewModel?.showUsersScreen(userId: userId)
    }

    
    
//    MARK: - cell height
    
    
    func calculateTextHeight(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), width: CGFloat) {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = NSString(string: text).boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        if let indexPath = indexPath {
            delegate?.postCellHeightDidChange(ceil(boundingRect.height) + 200, at: indexPath)
        }
    }

    
//    MARK: - Post id
    var postId: String = ""
    var userId:String = ""
    func configure(with post: Datum) {
        let text = post.content ?? ""
        let width = postContent.bounds.width
        calculateTextHeight(text: text, width: width)
        postId = post.id ?? ""
        userId = post.createdBy?.id ?? ""
        postContent.text = post.content
        userName.text = post.createdBy?.name ?? "Name"
        userNickName.text = post.createdBy?.userName ?? "UserName"
        postTime.text = DateFormat.timeAgoString(from: post.createdAt ?? "")
        if let likesCount = post.likesCount{
            numberOfLikes.text = "\(likesCount)"
        }
        
    }


}
