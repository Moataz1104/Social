//
//  HomeView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 08/04/2024.
//

import UIKit

struct Post {
    let title: String
    let content: String
}


class HomeView: UIViewController , AddPostCellDelegate{
    
    var cellHeight: CGFloat?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
        generateFakeData()
    }

    // MARK: - Cell Height Delegate
    func cellHeightDidChange(_ height: CGFloat) {
        cellHeight = height
    }

    // MARK: - Actions
    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Privates
    func generateFakeData() {
        for i in 1...100 {
            let post = Post(title: "Post \(i)", content: "Content for post \(i)")
            posts.append(post)
        }
    }
    
    private func registerCells(){
        collectionView.register(UINib(nibName: AddPostCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddPostCell.identifier)
        collectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: "PostCell")
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
            return posts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostCell.identifier, for: indexPath) as! AddPostCell
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostsCell
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: cellHeight ?? 150)
        } else {
            return CGSize(width: collectionView.bounds.width, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust this value as needed
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        }
    }

}
