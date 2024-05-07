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
    var disposeBag : DisposeBag? = DisposeBag()

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
        disposeBag = DisposeBag()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        getPostCellHeight()
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
    
    func getPostCellHeight(){
        let maxSize = CGSize(width: postContent.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let totalHeight = postContent.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: postContent.font ?? UIFont.systemFont(ofSize: 16)], context: nil).height ?? 0

        if let indexPath = indexPath {
            delegate?.postCellHeightDidChange(totalHeight + 200, at: indexPath)
        }
        
    }
    
    
//    MARK: - Post id
    var postId: String = ""
    var userId:String = ""
    func configure(with post: Datum) {
        postId = post.id ?? ""
        userId = post.createdBy?.id ?? ""
        postContent.text = post.content
        userName.text = post.createdBy?.name ?? "Name"
        userNickName.text = post.createdBy?.userName ?? "UserName"
        if let likesCount = post.likesCount{
            numberOfLikes.text = "\(likesCount)"
        }
    }


}
