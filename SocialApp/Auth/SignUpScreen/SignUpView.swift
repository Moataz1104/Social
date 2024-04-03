//
//  SignUpView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class SignUpView: UIViewController {

    
    //    MARK: - Properties

    private var viewModel:SignUpViewModel
    
    //    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainStack: UIStackView!
    
    
    //    MARK: - view controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        keyBoardWillAppear()
        keyBoardWillDisappear()
        
        mainStack.spacing = view.frame.height * 0.04
    }
    
    init(viewModel : SignUpViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Actions

    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func logInButton(_ sender: Any) {
        viewModel.popBack()
    }
    
    
    //    MARK: - Private functions
    
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
