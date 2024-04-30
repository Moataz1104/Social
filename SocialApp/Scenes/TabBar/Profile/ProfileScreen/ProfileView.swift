//
//  ProfileView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import UIKit

class ProfileView: UIViewController {

    @IBOutlet weak var collectionView:UICollectionView!
    private var viewModel : ProfileViewModel
    
    var postsCellHeights: [IndexPath: CGFloat] = [:]
    var posts: [Post] = []
    var isMyPostsSelected = true
    
    //    MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()
        
        generateFakeData()
        
        keyBoardWillAppear()
        keyBoardWillDisappear()

    }
    init(viewModel: ProfileViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - ACtions
    @IBAction func tapGestureEndEditing(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func messagesButtonAction(_ sender: Any) {
        viewModel.showMessagesScreen()
    }
    
    //    MARK: - Private functions


    private func registerCell(){
        collectionView.register(UINib(nibName: UserProfileDetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: UserProfileDetailsCell.identifier)
        collectionView.register(UINib(nibName: PostsCell.identifier, bundle: nil),forCellWithReuseIdentifier: PostsCell.identifier)
        collectionView.register(UINib(nibName: AddUserInfoCell.identifier, bundle: nil),forCellWithReuseIdentifier: AddUserInfoCell.identifier)

    }
    
    private func generateFakeData() {
        let post1 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post1)
        let post2 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is")
        posts.append(post2)
        let post3 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post3)
        let post4 = Post(title: "", content: "In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈In today's fast-paced, digitally driven world, digital marketing is not just a strategy; it's a necessity for businesses of all sizes. 📈")
        posts.append(post4)
        
    }
    


}


extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if isMyPostsSelected {
                return posts.count
            }else{
                return 1
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserProfileDetailsCell.identifier, for: indexPath) as! UserProfileDetailsCell
            cell.delegate = self
            return cell
        }else{
            if isMyPostsSelected{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as! PostsCell
                cell.postContent.text = posts[indexPath.item].content
                cell.delegate = self
                cell.indexPath = indexPath
//                cell.isThisMyPost = true
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddUserInfoCell.identifier, for: indexPath) as! AddUserInfoCell
                
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: 250)
        } else {
            let cellIndexPath = IndexPath(item: indexPath.item, section: 1)
            return CGSize(width: collectionView.bounds.width, height: isMyPostsSelected ? postsCellHeights[cellIndexPath] ?? 260 : 300)
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


extension ProfileView : UserProfileDetailsCellDelegate{
    func tabBarItemSelected(tag: Int) {
        if tag == 1000{
            isMyPostsSelected = true
            collectionView.reloadData()
        }else if tag == 1001{
            isMyPostsSelected = false
            collectionView.reloadData()

        }
    }
        
    
}

extension ProfileView : PostsCellDelgate{
    func postCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        postsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)
    }

}


extension ProfileView{
    private func keyBoardWillAppear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func keyBoardWillDisappear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardAppear(notification : NSNotification){
        if let keyBoardFrame : NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyBoardHeight = keyBoardFrame.cgRectValue.height - 100
            collectionView.contentInset.bottom = keyBoardHeight
            
        }
    }
    
    @objc func keyBoardDisappear(){
        collectionView.contentInset = .zero
        
    }
    
    
    
    
}


