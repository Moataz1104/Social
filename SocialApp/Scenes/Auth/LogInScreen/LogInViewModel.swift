//
//  LogInViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

class LogInViewModel {
    let disposeBag : DisposeBag
    weak var coordinator : AuthCoordinator?
    
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let errorSubjectMessage = PublishSubject<String>()
    let mainButtonSubject = PublishRelay<Void>()

    init(coordinator: AuthCoordinator,disposeBag : DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBag
        
        subscribeToErrorPublisher()
        
        sendRequest()

    }
    
    //    MARK: - Request
    
    private func combineFields() -> Observable<(String,String)> {
        Observable.combineLatest(emailSubject, passwordSubject)
    }
    
    private func sendRequest(){
        mainButtonSubject
            .withLatestFrom(combineFields())
            .do {email,password in
                APIAuth.shared.logInUser(email: email, password: password)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func subscribeToErrorPublisher(){
        APIAuth.shared.errorPublisher
            .subscribe {[weak self] event in
                print(event.element?.localizedDescription ?? "")
                self?.errorSubjectMessage.onNext(event.element?.localizedDescription ?? "No Description")
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
    //    MARK: - TextFields Validation
    private func isEmailFieldNotEmpty()-> Observable<Bool>{
        emailSubject
            .map{!$0.isEmpty}
    }
    private func isPasswordFieldNotEmpty()-> Observable<Bool>{
        passwordSubject
            .map{!$0.isEmpty}
    }
    
    func isMainButtonDisabled()-> Observable<Bool>{
        Observable
            .combineLatest(isEmailFieldNotEmpty(), isPasswordFieldNotEmpty())
            .map { tf1,tf2 in
                return tf1 && tf2
            }
            .startWith(false)
    }


    
    //    MARK: - Navigation
    func signUpButtonTap(){
        coordinator?.showSignUpScreen()
    }
}