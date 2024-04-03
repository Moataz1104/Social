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
    
    private var isKeyBoardExpanding = false
    
    //    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: AuthTextFields!
    @IBOutlet weak var passwordTextField: AuthTextFields!
    

    init(viewModel : LogInViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //    MARK: - view controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        keyBoardWillApear()
        keyBoardWillDisapear()
    }

    
//    MARK: - Actions
    
    @IBAction func tabGestureAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        print("taaap")
        viewModel.signUpButtonTap()
    }
    
    
    //    MARK: - Private functions
    
    private func keyBoardWillApear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardApear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    private func keyBoardWillDisapear(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDisapear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardApear(){
        if !isKeyBoardExpanding{
            scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height + 150)
            isKeyBoardExpanding = true
        }
    }

    @objc func keyBoardDisapear(){
        if isKeyBoardExpanding{
            scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height - 150)
            isKeyBoardExpanding = false
        }
    }

    
}
