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
    
    var commentsCellHeights: [IndexPath: CGFloat] = [:]
    let viewModel : CommentViewModel

//    MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        collectionView.dataSource = self
        collectionView.delegate = self

        userImage.layer.cornerRadius = userImage.bounds.width / 2
        userImage.clipsToBounds = true
        
        keyBoardWillAppear()
        keyBoardWillDisappear()
        
        reloadCollectionViewClosure()
        registerCell()
        
    }
    init(viewModel:CommentViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Privates
    private func registerCell(){
        collectionView.register(UINib(nibName: CommentCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CommentCell.cellIdentifier)
    }
    private func reloadCollectionViewClosure(){
        viewModel.reloadDataClosure = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self?.collectionView.reloadData()
            }
        }
    }

    
//    MARK: - Height delegate
    func commentCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        commentsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)

    }


}
    
    

// MARK: - Collection View data source

extension CommentsView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.commentData?.result ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCell.cellIdentifier, for: indexPath) as! CommentCell
                
        cell.indexPath = indexPath
        cell.delegate = self
        cell.commentContent.text =
        viewModel.commentData?.data?[indexPath.item].content ?? ""
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


