//
//  Album.swift
//  FinalProject
//
//  Created by NXH on 10/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import ObjectMapper

final class Album: Mappable {
    var id: String = ""
    var name: String = ""
    var coverPhoto: String = ""
    
    init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        coverPhoto <- map["cover_photo.source"]
    }
}
