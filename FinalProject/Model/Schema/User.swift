//
//  User.swift
//  FinalProject
//
//  Created by NXH on 9/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class User {
    var email: String
    var name: String
    var id: String
    
    init(email: String, name: String, id: String) {
        self.email = email
        self.name = name
        self.id = id
    }
}
