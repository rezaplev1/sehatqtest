//
//  Extension.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

enum UserDefaultsKeys : String {
    case isLogin
}

extension Double {
    
    var clean: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        let value = Double(self)
        let stringValue = formatter.string(from: NSNumber(value: value )) ?? "0"
        return stringValue
    }
}

extension UIViewController {
    
    func setNavTitle(withTitle: String, withBackButton: Bool = true) {
        self.navigationItem.title = withTitle
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backImage = UIImage(named: "backLogo")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.tintColor = .black
        
        if withBackButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func simpleAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UserDefaults {
    
    func setIsLogin(value: Bool){
        set(value, forKey: UserDefaultsKeys.isLogin.rawValue)
    }
    
    func getIsLogin() -> Bool {
        return value(forKey: UserDefaultsKeys.isLogin.rawValue) as? Bool ?? false
    }
}
