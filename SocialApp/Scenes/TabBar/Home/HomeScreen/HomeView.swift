//
//  HomeView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 08/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

struct Post {
    let title: String
    let content: String
}


class HomeView: UIViewController , AddPostCellDelegate , PostsCellHeightDelgate{
    private var viewModel : HomeViewModel

    let disposeBag : DisposeBag
    
    var cellHeight: CGFloat?
    var postsCellHeights: [IndexPath: CGFloat] = [:]

    var refreshControl = UIRefreshControl()

    @IBOutlet weak var collectionView: UICollectionView!
    
    
//    MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        
        showingNetworkErrorAlert()
        
        reloadCollectionViewClosure()
        
        
        refreshCollectionView()

    }

    
    init(viewModel : HomeViewModel,disposeBag:DisposeBag){
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Height Delegate
    func cellHeightDidChange(_ height: CGFloat) {
        cellHeight = height
    }
    
    func postCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        postsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
//    MARK: - RX Binding
    func bindPostButtonTap(postButton:UIButton , bag:DisposeBag){
        postButton.rx.tap
            .bind(to: viewModel.postButtonSubject)
            .disposed(by: bag)
        
    }
    
    func bindToPostSubject(postTextView:UITextView,bag:DisposeBag){
        postTextView.rx.text.orEmpty.bind(to: viewModel.addPostContentSubject)
            
            .disposed(by: bag)

    }

    //MARK: - Networking
    
    private func showingNetworkErrorAlert(){
        viewModel
            .errorSubjectMessage
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] errorMessage in
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
            }
            .disposed(by: disposeBag)
    }

    
    
    // MARK: - Privates
    
    private func registerCells(){
        collectionView.register(UINib(nibName: AddPostCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddPostCell.identifier)
        collectionView.register(UINib(nibName: PostsCell.identifier, bundle: nil), forCellWithReuseIdentifier: PostsCell.identifier)
    }
    
    
    private func reloadCollectionViewClosure(){
        viewModel.reloadDataClosure = { [weak self] in
            DispatchQueue.main.async {
                let sectionToReload = IndexSet(integer: 1)
                self?.collectionView.reloadSections(sectionToReload)
                
            }
        }
    }
    
    private func refreshCollectionView(){
        collectionView.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

    }
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.viewModel.getAllPosts()
            self.refreshControl.endRefreshing()
        }
    }

}




extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.posts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostCell.identifier, for: indexPath) as! AddPostCell
            cell.delegate = self
            if let bag = cell.disposeBag{
                bindPostButtonTap(postButton: cell.postButton, bag: bag)
                bindToPostSubject(postTextView: cell.postTextView, bag: bag)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as! PostsCell
            let post = viewModel.posts[indexPath.item]
            
            cell.configure(with: post)
            cell.delegate = self
            cell.indexPath = indexPath
            cell.viewModel = viewModel
            cell.postDelegate = self
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: cellHeight ?? 150)
        } else {
            let cellIndexPath = IndexPath(item: indexPath.item, section: 1)
            return CGSize(width: collectionView.bounds.width, height: postsCellHeights[cellIndexPath] ?? 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        }
    }
    
}



extension HomeView: PostsCellDelegate {
    
    func postCellDidLike(_ postId: String) {
        viewModel.postId = postId
        viewModel.likeButtonSubject.accept(())
    }
    
    func postCellDidPressComment(_ postId: String) {
        viewModel.postId = postId
        viewModel.commentButtonSubject.accept(())
    }

}
