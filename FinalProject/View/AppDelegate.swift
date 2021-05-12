//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Nhi Kieu H. on 9/10/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import IQKeyboardManager
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum RootType {
        case loginVC
        case tabbar
    }

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return shared
    }()
    var window: UIWindow?
    let login: ViewController = LoginViewController()
    let tabbar: TabbarViewController = TabbarViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if let _ = Session.shared.ud.value(forKey: FacebookKey.isLogin) {
        window?.rootViewController = tabbar
        } else {
            window?.rootViewController = login
        }
        
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions)
        configFirebaseApp()
        configSVProgressHUD()
        configIQKeyboardManager()
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = ApplicationDelegate.shared.application(app,
                                                        open: url,
                                                        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                        annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return handled
    }
        
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    func changeRoot(rootType: RootType) {
        switch rootType {
        case .loginVC:
            window?.rootViewController = login
        default:
            tabbar.selectedIndex = 0
            window?.rootViewController = tabbar
        }
    }
    
    func configFirebaseApp() {
        FirebaseApp.configure()
    }
    
    func configSVProgressHUD() {
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    func configIQKeyboardManager() {
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
}

