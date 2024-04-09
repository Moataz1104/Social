//
//  AddPostCell.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 08/04/2024.
//

import UIKit

protocol AddPostCellDelegate:AnyObject{
    func cellHeightDidChange(_ height:CGFloat)
}


class AddPostCell: UITableViewCell , UITextViewDelegate {
    
    static let identifier = "AddPostCell"
    weak var delegate : AddPostCellDelegate?
    
    
    @IBOutlet weak var postTextView: UITextView!
    
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var addMediaButtin : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postTextView.delegate = self
        configureUi()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func configureUi(){
        postTextView.textColor = UIColor.lightGray
        postButton.layer.cornerRadius = postButton.frame.height / 2
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true

    }
    
    
}


extension AddPostCell{
    func textViewDidChange(_ textView: UITextView) {
        let newSize = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        textFieldHeightConstraint.constant = newSize.height
        delegate?.cellHeightDidChange(newSize.height + 150)
         
        
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "What's on your mind?" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind?"
            textView.textColor = UIColor.lightGray
        }
    }

    

}
