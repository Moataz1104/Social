//
//  UsersView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/05/2024.
//

import UIKit
import RxSwift
import RxCocoa

class UsersView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel : UsersViewModel
    let disposeBag : DisposeBag
    var postsCellHeights: [IndexPath: CGFloat] = [:]



//    MARK: - View Controller life cycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }

    init(viewModel : UsersViewModel,disposeBag:DisposeBag){
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


// MARK: - Privates
    
    private func registerCells(){
        collectionView.register(UINib(nibName: UsersDetailsCell.identifier, bundle: nil), forCellWithReuseIdentifier: UsersDetailsCell.identifier)
        collectionView.register(UINib(nibName: PostsCell.identifier, bundle: nil), forCellWithReuseIdentifier: PostsCell.identifier)
    }

}


extension UsersView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersDetailsCell.identifier, for: indexPath) as! UsersDetailsCell
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCell.identifier, for: indexPath) as! PostsCell
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height:250)
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

extension UsersView : PostsCellHeightDelgate{
    func postCellHeightDidChange(_ height: CGFloat, at indexPath: IndexPath) {
        postsCellHeights[indexPath] = height
        collectionView.performBatchUpdates(nil, completion: nil)

    }
    
    
}
