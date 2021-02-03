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
        label.textAlignment = .center
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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.setTitle("Sign in", for: .normal)
        button.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return button
    }()
    
    
    var faceBookButton: FBLoginButton = {
        let button = FBLoginButton()
        button.addTarget(self, action: #selector(didTapFaceBook), for: .touchUpInside)
        return button
    }()
    
    var googleButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Google Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(didTapGoogle), for: .touchUpInside)
        return button
    }()
    
    var vm = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sutupView()
        
        vm.delegate = self
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
            make.size.equalTo(faceBookButton)
        }
        
    }
    
    @objc func didTapLogin() {
        vm.validateLogin(username: userNameTextField.text, password: passwordTextField.text)
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
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: - Login With Facebook
    
    func loginManagerDidComplete(_ result: LoginResult) {
        print(result)
        switch result {
        case .cancelled:
            print("cancelled login")
        case .failed(let error):
            simpleAlert(message: "\(error)", title: "Login Failed")
        case .success(_, _, let token):
            vm.loginWithFacebookGoogle(token: token.tokenString)
        }
    }
}

// MARK : - GIDSignInDelegate
extension LoginViewController : GIDSignInDelegate {
    
    // MARK : - GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            
            if let token = user.authentication.idToken {
                vm.loginWithFacebookGoogle(token: token)
            }
            
        } else {
            if (error.localizedDescription.contains("The user canceled the sign-in flow")) {
                print("didSignInForUser user cancel")
            } else {
                // error login
            }
        }
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    
    func failed(message: String) {
        simpleAlert(message: message)
    }
    
    func success() {
        UserDefaults.standard.setIsLogin(value: true)
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
