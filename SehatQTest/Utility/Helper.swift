//
//  Helper.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import Foundation
import Alamofire

public class Helper {
    
    //MARK : CHECKING IS CONNECTING TO NETWORK
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func checkSessionController() -> UIViewController {
        
        if (UserDefaults.isLogin()) {
            
            return MainViewController()
        }
        
        return LoginViewController()
    }
}
