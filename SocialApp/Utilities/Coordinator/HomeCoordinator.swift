//
//  HomeCoordinator.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 07/04/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class HomeCoordinator:Coordinator{
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    init( navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let disposeBag = DisposeBag()
        let viewModel = HomeViewModel(coordinator: self, disposeBag: disposeBag)
        let vc = HomeView(viewModel: viewModel, disposeBag: disposeBag)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCommentScreen(postId:String){
        let disposeBag = DisposeBag()
        let viewModel = CommentViewModel(postID: postId, disposeBag: disposeBag)
        let vc = CommentsView(viewModel: viewModel, disposeBag: disposeBag)
        let newNavController = UINavigationController(rootViewController: vc)
        newNavController.modalPresentationStyle = .pageSheet
        navigationController.present(newNavController, animated: true, completion: nil)

    }
    
    func showUsersScreen(){
        let disposeBag = DisposeBag()
        let viewModel = UsersViewModel(coordinator: self, disposeBag: disposeBag)
        let vc = UsersView(viewModel: viewModel, disposeBag: disposeBag)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
