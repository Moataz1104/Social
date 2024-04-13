//
//  CommentsView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 12/04/2024.
//

import UIKit

class CommentsView: UIViewController {

    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var scrollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        
        keyBoardWillAppear()
        keyBoardWillDisappear()

    }


    
    //    MARK: - Private functions
    
    private func keyBoardWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func keyBoardWillDisappear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardAppear(notification : NSNotification){
        if let keyBoardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyBoardHeight = keyBoardFrame.cgRectValue.height
            scrollView.contentInset.bottom = keyBoardHeight

        }
    }
    
    @objc func keyBoardDisappear(){
        scrollView.contentInset = .zero

    }


}
