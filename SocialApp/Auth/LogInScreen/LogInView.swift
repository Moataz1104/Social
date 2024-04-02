//
//  LogInView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 01/04/2024.
//

import UIKit

class LogInView: UIViewController {
    
//    MARK: - Properties
    private var isKeyBoardExpanding = false
    
//    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
//    MARK: - view controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoardWillApear()
        keyBoardWillDisapear()
    }

    
//    MARK: - Actions
    
//    MARK: - Private functions
    
    private func keyBoardWillApear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func keyBoardWillDisapear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardApear(){
        if !isKeyBoardExpanding{
            scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height + 250)
            isKeyBoardExpanding = true
        }
        print("Number 1")
    }

    @objc func keyBoardDisapear(){
        if isKeyBoardExpanding{
            scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height - 250)
            isKeyBoardExpanding = false
        }
        print("Number 2222")


    }

    
}
