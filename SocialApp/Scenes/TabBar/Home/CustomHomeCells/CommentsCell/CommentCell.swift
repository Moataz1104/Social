//
//  CommentCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 14/04/2024.
//

import UIKit


protocol CommentCellDelegate:AnyObject{
    func commentCellHeightDidChange(_ height:CGFloat,at indexPath: IndexPath)
}

class CommentCell: UICollectionViewCell {
    static let cellIdentifier = "CommentCell"
    
    weak var delegate : CommentCellDelegate?
    var indexPath : IndexPath?

    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userNickName:UILabel!
    @IBOutlet weak var commentContent:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        getPostCellHeight()
    }

    
    func getPostCellHeight(){
        let maxSize = CGSize(width: commentContent.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let totalHeight = commentContent.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: commentContent.font ?? UIFont.systemFont(ofSize: 16)], context: nil).height ?? 0

        if let indexPath = indexPath {
            delegate?.commentCellHeightDidChange(totalHeight + 100, at: indexPath)
        }
        
    }


}
