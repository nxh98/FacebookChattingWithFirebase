//
//  LoginViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class LoginViewController: ViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var loginFacebookButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: LoginViewModel = LoginViewModel()
    
    // MARK: - @Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private functions
    
    private func login() {
        viewModel.login { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .failure:
                let alert: UIAlertController = UIAlertController(title: AlertKey.notification, message: AlertKey.loginFailure, preferredStyle: .alert)
                let aletAction: UIAlertAction = UIAlertAction(title: AlertKey.okAction, style: .destructive, handler: nil)
                alert.addAction(aletAction)
                this.present(alert, animated: true, completion: nil)
            case .success:
                Session.shared.ud.set(true, forKey: FacebookKey.isLogin)
                AppDelegate.shared.changeRoot(rootType: .tabbar)
            }
        }
    }
    
    // MARK: - @IBAction
    @IBAction private func loginFacebookTouchUpInside() {
        login()
    }
}
