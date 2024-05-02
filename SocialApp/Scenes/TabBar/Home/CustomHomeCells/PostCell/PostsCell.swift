//
//  PostCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 09/04/2024.
//

import UIKit
import RxSwift
import RxCocoa


protocol PostsCellDelgate:AnyObject{
    func postCellHeightDidChange(_ height:CGFloat,at indexPath: IndexPath)
}

protocol PostsCellDelegate: AnyObject {
    func postCellDidLike(_ postId: String)
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

    weak var delegate : PostsCellDelgate?
    weak var postDelegate: PostsCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }


    
    override func layoutSubviews() {
        super.layoutSubviews()
        getPostCellHeight()
    }
    
    @IBAction func commentButtonAction(_ sender: Any) {
        viewModel?.showCommentsScreen()
        
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        postDelegate?.postCellDidLike(postId)
    }
    

    
    func getPostCellHeight(){
        let maxSize = CGSize(width: postContent.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let totalHeight = postContent.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: postContent.font ?? UIFont.systemFont(ofSize: 16)], context: nil).height ?? 0

        if let indexPath = indexPath {
            delegate?.postCellHeightDidChange(totalHeight + 200, at: indexPath)
        }
        
    }
    
    
//    MARK: - Post id
    var postId: String = ""

    func configure(with post: Datum) {
        postId = post.id ?? ""
        postContent.text = post.content
    }


}
