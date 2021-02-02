//
//  LoginViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit
import SnapKit
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    var loginTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.textAlignment = .justified
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 0
        label.text = "Login"
        return label
    }()
    
    var userNameTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.placeholder = "UserName"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var passwordTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.placeholder = "Password"
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    
    var faceBookButton: FBLoginButton = {
        let button = FBLoginButton()
//        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didTapFaceBook), for: .touchUpInside)
        return button
    }()
    
    var googleButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(didTapGoogle), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        sutupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func sutupView() {
        view.backgroundColor = .white
        
        view.addSubview(loginTitleLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(faceBookButton)
        view.addSubview(googleButton)
        
        
        loginTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(-40)
            make.left.equalTo(40)
            make.height.equalTo(47)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(32)
            make.right.equalTo(-40)
            make.left.equalTo(40)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(16)
            make.right.equalTo(-40)
            make.left.equalTo(40)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.right.equalTo(-40)
            make.width.equalTo(187)
            make.height.equalTo(44)
        }
        
        faceBookButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(32)
            make.right.equalTo(-40)
            make.left.equalTo(40)
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(faceBookButton.snp.bottom).offset(16)
            make.right.equalTo(-40)
            make.left.equalTo(40)
            make.height.equalTo(44)
        }
        
    }
    
    @objc func didTapLogin() {
    }
    
    @objc func didTapFaceBook() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(
            permissions: [.publicProfile, .userFriends],
            viewController: self
        ) { result in
            self.loginManagerDidComplete(result)
        }
    }
    
    @objc func didTapGoogle() {
    }
    
    // MARK: - Login With Facebook
    
    func loginManagerDidComplete(_ result: LoginResult) {
        print(result)
        switch result {
        case .cancelled:
            print("cancelled login")
        case .failed(let error):
            simpleAlert(message: "Login Failed")
        case .success(_, _, let token):
            simpleAlert(message: "Login success")
//            loginVM?.loginWithFacebookGoogle(token: token.tokenString)
        }
    }
}
