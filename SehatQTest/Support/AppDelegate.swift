//
//  AppDelegate.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit
import GoogleSignIn
import FacebookCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize google sign-in
        GIDSignIn.sharedInstance().clientID = Constants.GOOGLE_CLIENT_ID
        let navigation = UINavigationController(rootViewController: Helper.checkSessionController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled = false
        
        if (url.scheme?.hasPrefix("fb"))! {
            handled = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        } else {
            handled = GIDSignIn.sharedInstance().handle(url)
        }
        
        return handled
    }

}
