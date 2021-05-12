//
//  DetailsFriend.swift
//  FinalProject
//
//  Created by NXH on 10/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class DetailsFriend {

    var id: String
    var coverImage: String
    var quotes: String
    var homeTown: String
    var location: String
    var gender: String
    var name: String
    var avatar: String
    var birthday: String
    var countFriends: Int
    
    init(id: String = "", name: String = "", quotes: String = "",
         hometown: String = "", location: String = "", gender: String = "",
         birthday: String = "__/__/__", avatar: String = "", coverImage: String = "",
         countFriends: Int = 0) {
        self.id = id
        self.avatar = avatar
        self.birthday = birthday
        self.coverImage = coverImage
        self.gender = gender
        self.homeTown = hometown
        self.location = location
        self.quotes = quotes
        self.name = name
        self.countFriends = countFriends
    }
}
