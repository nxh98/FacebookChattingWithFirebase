//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/23/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import MVVM

final class LoginViewModel: ViewModel {
    
    // MARK: - Properties
    private let facebookLogin: LoginManager = LoginManager()
    // MARK: - Functions
    func login(completion: @escaping FBCompletion) {
        let vc = LoginViewController()
        facebookLogin.logIn(permissions: [FacebookKey.email,
                                          FacebookKey.friends,
                                          FacebookKey.photos,
                                          FacebookKey.birthday,
                                          FacebookKey.hometown,
                                          FacebookKey.gender,
                                          FacebookKey.location,
                                          FacebookKey.likes,
                                          FacebookKey.link,
                                          FacebookKey.posts,
                                          FacebookKey.status],
                            from: vc) { (result, error) in
            if let result = result?.isCancelled, result {
            } else {
                if error == nil {
                    if let token = AccessToken.current, !token.isExpired {
                        Session.shared.accessToken = token.tokenString
                        completion(.success)
                    }
                } else {
                    completion(.failure)
                }
            }
        }
    }
}

// MARK: - extension
extension LoginViewModel {
    
    enum LoginFacebookResult {
        case success
        case failure
    }
    
    enum ConnectFacebookToFirebaseResult {
        case success
        case failure
    }
}
