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

    
    func calculateTextHeight(text: String, font: UIFont = UIFont.systemFont(ofSize: 17), width: CGFloat) {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = NSString(string: text).boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        if let indexPath = indexPath {
            delegate?.commentCellHeightDidChange(ceil(boundingRect.height) + 150, at: indexPath)
        }
    }

    func configureCell(comment:String){
        calculateTextHeight(text: comment, width: commentContent.bounds.width)
        commentContent.text = comment
    }

}
