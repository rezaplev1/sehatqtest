//
//  LoginViewModel.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation


protocol LoginViewModelDelegate : class {
    func success()
    func failed(message: String)
}

class LoginViewModel: BaseViewModel {
    
    var delegate: LoginViewModelDelegate?
    
    func loginWithFacebookGoogle(token:String?) {
        if let data = token, !data.isEmpty {
            self.delegate?.success()
        }else{
            delegate?.failed(message: "gagal menghubungkan")
        }
        
    }
    
    func validateLogin(username:String?, password:String?) {
        guard let username = username, !username.isEmpty else {
            
            delegate?.failed(message: "UserName tidak boleh kosong")
            return
        }
        
        guard let password = password, !password.isEmpty else {
            delegate?.failed(message: "password tidak boleh kosong")
            return
        }
        
        self.delegate?.success()
    }
}
