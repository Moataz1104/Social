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


class HomeView: UIViewController , AddPostCellDelegate , PostsCellDelgate{
    private var viewModel : HomeViewModel

    let disposeBag : DisposeBag
    
    var cellHeight: CGFloat?
    var postsCellHeights: [IndexPath: CGFloat] = [:]
    var posts: [Post] = []

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
//    MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        generateFakeData()
        
        showingNetworkErrorAlert()
        
        reloadCollectionViewClosure()
        

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
    func bindPostButtonTap(postButton:UIButton){
        postButton.rx.tap
            .bind(to: viewModel.postButtonSubject)
            .disposed(by: disposeBag)
    }
    
    func bindToPostSubject(postTextView:UITextView){
        postTextView.rx.text.orEmpty.bind(to: viewModel.addPostContentSubject)
            .disposed(by: disposeBag)

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
    func generateFakeData() {
        let post1 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post1)
        let post2 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is")
        posts.append(post2)
        let post3 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post3)
        let post4 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post4)
        
    }
    
    private func registerCells(){
        collectionView.register(UINib(nibName: AddPostCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddPostCell.identifier)
        collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
    }
    
    
    private func reloadCollectionViewClosure(){
        viewModel.reloadDataClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
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
            bindPostButtonTap(postButton: cell.postButton)
            bindToPostSubject(postTextView: cell.postTextView)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostsCell
            cell.postContent.text = viewModel.posts[indexPath.item].content /*posts[indexPath.item].content*/
            cell.delegate = self
            cell.indexPath = indexPath
            cell.viewModel = viewModel
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


