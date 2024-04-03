//
//  LogInView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 01/04/2024.
//

import UIKit

class LogInView: UIViewController {
    

    //    MARK: - Properties
    private var viewModel : LogInViewModel
    
    
    //    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: AuthTextFields!
    @IBOutlet weak var passwordTextField: AuthTextFields!
    
    //    MARK: - view controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        keyBoardWillAppear()
        keyBoardWillDisappear()
    }

    
    init(viewModel : LogInViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//    MARK: - Actions
    
    @IBAction func tabGestureAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        viewModel.signUpButtonTap()
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
