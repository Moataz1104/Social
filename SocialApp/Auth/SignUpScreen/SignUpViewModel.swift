//
//  SignUpViewModel.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import Foundation
import RxSwift

class SignUpViewModel {
    let disposeBag : DisposeBag
    weak var coordinator : AuthCoordinator?
    let userNameSubject = PublishSubject<String>()
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let confirmPasswordSubject = PublishSubject<String>()

    
    init(coordinator: AuthCoordinator,disposeBage : DisposeBag) {
        self.coordinator = coordinator
        self.disposeBag = disposeBage
        
    }
    


    //    MARK: - TextFields Validation
    func isUserNameValid() -> Observable<Bool>{
        userNameSubject
            .map(Validation.isValidUserName(_:))
    }
    
    func isEmailValid() -> Observable<Bool>{
        emailSubject
            .map(Validation.isValidEmail(_:))
    }

    func isPasswordValid() -> Observable<Bool>{
        passwordSubject
            .map(Validation.isPasswordValid(_:))
    }
    
    func arePasswordsEqual()-> Observable<Bool>{
        Observable.combineLatest(passwordSubject, confirmPasswordSubject)
            .flatMapLatest { password, confirmPassword in
                return Observable.just(password == confirmPassword)
            }

    }
    
    func isMainButtonDisabled()-> Observable<Bool>{
        Observable
            .combineLatest(isUserNameValid(), isEmailValid(), isPasswordValid(), arePasswordsEqual())
            .map { tf1,tf2,tf3,tf4 in
                return tf1 && tf2 && tf3 && tf4
            }
            .startWith(false)
        
        
    }

    
//    MARK: - Request
    
    func requestTest() -> Disposable{
        Observable.combineLatest(userNameSubject, emailSubject, passwordSubject, confirmPasswordSubject)
            .subscribe { username,email,pass,confirmPaas in
                print("userName: \(username) \n email: \(email) \n password:\(pass) \n confirmPassword: \(confirmPaas)")
            }
    }
    

    
    
    
//    MARK: - Navigation
    func popBack(){
        coordinator?.popVC()
    }
}
