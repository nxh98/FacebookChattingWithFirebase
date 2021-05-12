//
//  Friends.swift
//  FinalProject
//
//  Created by NXH on 9/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

final class Friends: Object, Mappable {
    
     @objc dynamic var name: String = ""
     @objc dynamic var image: String = ""
     @objc dynamic var id: String = ""
    
    init?(map: Map) {
    }
    
    required override init() {
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        image <- map["picture.data.url"]
        id <- map["id"]
    }
    
}
