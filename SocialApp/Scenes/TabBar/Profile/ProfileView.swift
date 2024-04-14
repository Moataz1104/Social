//
//  ProfileView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import UIKit

class ProfileView: UIViewController {

    @IBOutlet weak var collectionView:UICollectionView!
    
    var postsCellHeights: [IndexPath: CGFloat] = [:]
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCell()

    }

    // MARK: - Cell Height Delegate
    func cellHeightDidChange(_ height: CGFloat) {
    }
    
    func postCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        postsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)
    }

    private func registerCell(){
        collectionView.register(UINib(nibName: UserProfileDetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: UserProfileDetailsCell.identifier)
    }



}


extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        } else {
//            return posts.count
//        }
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserProfileDetailsCell.identifier, for: indexPath) as! UserProfileDetailsCell
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 250)
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
            collectionView.backgroundColor = .cyan
        }else if tag == 1001{
            collectionView.backgroundColor = .black
        }
        else{
            collectionView.backgroundColor = .cyan
        }
        
    }
        
    
}
