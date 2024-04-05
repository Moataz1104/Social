//
//  SignUpView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpView: UIViewController {

    
    //    MARK: - Properties

    private var viewModel:SignUpViewModel
    let disposeBag : DisposeBag
    //    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainButton: MainButton!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var userNameField: AuthTextFields!
    @IBOutlet weak var emailField: AuthTextFields!
    @IBOutlet weak var passwordField: AuthTextFields!
    @IBOutlet weak var confirmPasswordField: AuthTextFields!
    
    
    //    MARK: - view controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        // Handling KeyBoard
        keyBoardWillAppear()
        keyBoardWillDisappear()
        
        
        
        //Bining
        bindTextFields()
        bindMainButton()
        enablingMainButton()
        
        //TextFields Validation
        userNameValidation()
        emailValidation()
        passwordValidation()
        confirmingPasswords()
        
        //Networking
        showingNetworkErrorAlert()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainStack.spacing = view.frame.height * 0.04
    }
    
    init(viewModel : SignUpViewModel,disposeBage : DisposeBag){
        self.viewModel = viewModel
        self.disposeBag = disposeBage
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: - Actions

    @IBAction func tapGesture(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    
    @IBAction func logInButton(_ sender: Any) {
        viewModel.popBack()
    }
    
    
    
//    MARK: - RX Binding
    
    private func bindTextFields(){
        userNameField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.userNameField.text else { return }
                self?.viewModel.userNameSubject.onNext(text)
            })
            .disposed(by: disposeBag)

        emailField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.emailField.text else { return }
                self?.viewModel.emailSubject.onNext(text)
            })
            .disposed(by: disposeBag)

        passwordField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.passwordField.text else { return }
                self?.viewModel.passwordSubject.onNext(text)
            })
            .disposed(by: disposeBag)
        
        confirmPasswordField.rx.controlEvent(.editingDidEnd)
            .map { [weak self] in
                self?.confirmPasswordField.text ?? ""
            }
            .filter { !$0.isEmpty } // Filter out empty strings
            .subscribe(onNext: { [weak self] text in
                self?.viewModel.confirmPasswordSubject.onNext(text)
            })
            .disposed(by: disposeBag)


    }
    
    private func enablingMainButton(){
        viewModel.isMainButtonDisabled()
            .bind(to: mainButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindMainButton(){
        mainButton.rx.tap
            .bind(to: viewModel.mainButtonSubject)
            .disposed(by: disposeBag)
            
    }
    
//    MARK: - TextFields Validation
    
    private func userNameValidation(){
        viewModel.isUserNameValid()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isValid in
                if !isValid {
                    self?.present(Validation.popAlert(alertType: .invalidUerName), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func emailValidation(){
        viewModel.isEmailValid()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isValid in
                if !isValid {
                    self?.present(Validation.popAlert(alertType: .invalidEmail), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }

    private func passwordValidation(){
        viewModel.isPasswordValid()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isValid in
                if !isValid  {
                    self?.present(Validation.popAlert(alertType: .invalidPassword), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func confirmingPasswords(){
        viewModel.arePasswordsEqual()
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] areValid in
                if !areValid{
                    self?.present(Validation.popAlert(alertType: .passwordNotEqual), animated: true)
                }
            }
            .disposed(by: disposeBag)
    }


    //    MARK: - Networking Functions
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
