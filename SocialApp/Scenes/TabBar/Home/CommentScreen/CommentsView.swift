//
//  CommentsView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 12/04/2024.
//

import UIKit

class CommentsView: UIViewController , CommentCellDelegate {
    
    @IBOutlet weak var userImage:UIImageView!
    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var scrollView:UIScrollView!
    
    var comments: [String] = [] 
    var commentsCellHeights: [IndexPath: CGFloat] = [:]


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        collectionView.dataSource = self
        collectionView.delegate = self

        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        
        keyBoardWillAppear()
        keyBoardWillDisappear()
        
        generateFakeData()
        registerCell()
        
    }
    func generateFakeData() {
        let comment1 = "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈"
        comments.append(comment1)
        
        let comment2 = "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necIn today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈essity for businesses of all sizes. 📈"
        comments.append(comment2)

        let comment3 = "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a nIn today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈ecessity for businesses of all sizes. 📈"
        comments.append(comment3)

        let comment4 = "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a nIn today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈ecessity for businesses of all sizes. 📈"
        comments.append(comment4)

        
    }

    private func registerCell(){
        collectionView.register(UINib(nibName: CommentCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.cellIdentifier)
    }
    
    func commentCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        commentsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)

    }


}
    
    

// MARK: - Collection View data source

extension CommentsView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.cellIdentifier, for: indexPath) as! CommentCell
                
        cell.indexPath = indexPath
        cell.delegate = self
        cell.commentContent.text = comments[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellIndexPath = IndexPath(row: indexPath.item, section: 0)
            return CGSize(width: collectionView.bounds.width, height: commentsCellHeights[cellIndexPath] ?? 200)
    }
    
}
//    MARK: - Private functions
extension CommentsView{
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


