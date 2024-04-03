//
//  SignUpView.swift
//  SocialApp
//
//  Created by Moataz Mohamed on 02/04/2024.
//

import UIKit

class SignUpView: UIViewController {

    private var viewModel:SignUpViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    init(viewModel : SignUpViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
