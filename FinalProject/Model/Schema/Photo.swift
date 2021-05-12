//
//  Photo.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photo: Mappable {
    
    var image: String = ""
    var name: String = ""
    var likes: Int = 0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        image <- map["source"]
        name <- map["name"]
        likes <- map["likes.summary.total_count"]
    }
}

struct Photos: Mappable {
    var photos: [Photo] = []
    var nextToken: String = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        nextToken <- map["paging.cursors.after"]
    }
}
