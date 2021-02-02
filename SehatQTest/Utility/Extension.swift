//
//  Extension.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

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
    
    func simpleAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isLogin() -> Bool {
        let hasBeenLoginBeforeFlag = "hasBeenLoginBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLoginBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLoginBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
