//
//  Api.Products.swift
//  FinalProject
//
//  Created by NXH on 9/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import ObjectMapper

extension Api.InforUser {
    
    @discardableResult
    static func getUser(completion: @escaping Completion) -> Request? {
        let path = Api.Path.InforUser.userPath
        return api.request(method: .get, urlString: path, parameters: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let json = data as? JSObject,
                        let email = json["email"] as? String,
                        let name = json["name"] as? String,
                        let id = json["id"] as? String else {
                        return
                    }
                    let user: User = User(email: email, name: name, id: id)
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    @discardableResult
    static func getAllFriends(completion: @escaping Completion) -> Request? {
        let path = Api.Path.InforUser.allFriendPath
        return api.request(method: .get, urlString: path, parameters: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let json = data as? JSObject,
                        let friends = json["data"] as? JSArray
                    else {
                        return
                    }
                    let allFriend: [Friends] = Mapper<Friends>().mapArray(JSONArray: friends)
                    completion(.success(allFriend))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
