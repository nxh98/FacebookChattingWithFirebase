//
//  FriendsCellViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class FriendsCellViewModel {
    
    private(set) var name: String
    private(set) var image: String
    private(set) var id: String
    
    init(name: String, image: String, id: String) {
        self.name = name
        self.image = image
        self.id = id
    }
}
