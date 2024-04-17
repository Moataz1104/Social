//
//  LogInView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 01/04/2024.
//

import UIKit
import RxSwift
import RxCocoa
class LogInView: UIViewController {
    

    //    MARK: - Properties
    private var viewModel : LogInViewModel
    let disposeBag : DisposeBag
    
    //    Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainButton: MainButton!
    @IBOutlet weak var emailTextField: AuthTextFields!
    @IBOutlet weak var passwordTextField: AuthTextFields!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //    MARK: - view controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        keyBoardWillAppear()
        keyBoardWillDisappear()
        
        //Bining
        bindTextFields()
        bindMainButton()
        enablingMainButton()
        
        //Networking
        showingNetworkErrorAlert()
        
        activityIndicator.isHidden = true
        subscribeToActivityIndicator()

    }

    
    init(viewModel : LogInViewModel,disposeBag:DisposeBag){
        self.viewModel = viewModel
        self.disposeBag = disposeBag
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
    
    //    MARK: - RX Binding
    private func bindTextFields(){
        emailTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.emailTextField.text else { return }
                self?.viewModel.emailSubject.onNext(text)
            })
            .disposed(by: disposeBag)

        passwordTextField.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] in
                guard let text = self?.passwordTextField.text else { return }
                self?.viewModel.passwordSubject.onNext(text)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func bindMainButton(){
        mainButton.rx.tap
            .bind(to: viewModel.mainButtonSubject)
            .disposed(by: disposeBag)
    }

    private func enablingMainButton(){
        viewModel.isMainButtonDisabled()
            .bind(to: mainButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToActivityIndicator(){
        viewModel.activityIndicatorRelay
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] isAnimating in
                if isAnimating{
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                }else{
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()

                }
            }
            .disposed(by: disposeBag)

    }

    //MARK: - Networking
    
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
