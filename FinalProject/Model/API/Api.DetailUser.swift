//
//  Api.Products.swift
//  FinalProject
//
//  Created by NXH on 9/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire
//import CoreLocation
import ObjectMapper

extension Api.DetailUser {
    
    @discardableResult
    static func getDetailUser(completion: @escaping Completion) -> Request? {
        let path = Api.Path.DetailUser.path
        return api.request(method: .get, urlString: path, parameters: nil) { result in
            let detailFriends = DetailsFriend()
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let json = data as? JSObject {
                        if let id = json["id"] as? String {
                            detailFriends.id = id
                        }
                        if let picture = json["picture"] as? JSObject, let data = picture["data"] as? JSObject,
                            let urlPicture = data["url"] as? String {
                            detailFriends.avatar = urlPicture
                        }
                        if let hometown = json["hometown"] as? JSObject,
                            let nameHometown = hometown["name"] as? String {
                            detailFriends.homeTown = nameHometown
                        }
                        if let location = json["location"] as? JSObject,
                            let nameLocation = location["name"] as? String {
                            detailFriends.location = nameLocation
                        }
                        if let name = json["name"] as? String {
                            detailFriends.name = name
                        }
                        if let birthday = json["birthday"] as? String {
                            detailFriends.birthday = birthday
                        }
                        if let gender = json["gender"] as? String {
                            detailFriends.gender = gender
                        }
                        if let quotes = json["quotes"] as? String {
                            detailFriends.quotes = quotes
                        }
                        var urlCover: String?
                        if let albums = json["albums"] as? JSObject,
                            let dataAlbums = albums["data"] as? JSArray {
                            for (index, value) in dataAlbums.enumerated() {
                                if let name = value["name"] as? String {
                                    if name == "Ảnh bìa" {
                                        if let cover = dataAlbums[index]["cover_photo"] as? JSObject {
                                            urlCover = (cover["source"] as? String)
                                        }
                                    }
                                }
                            }
                        }
                        if let url = urlCover {
                            detailFriends.coverImage = url
                        }
                        
                        if let friends = json["friends"] as? JSObject,
                            let summary = friends["summary"] as? JSObject,
                            let count = summary["total_count"] as? Int {
                            detailFriends.countFriends = count
                        }
                    }
                    completion(.success(detailFriends))
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
    
    @discardableResult
    static func getAllAlbum(completion: @escaping Completion) -> Request? {
        let path = Api.Path.DetailUser.albumPath
        return api.request(method: .get, urlString: path, parameters: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let json = data as? JSObject, let albums = json["albums"] as? JSObject {
                        if let datas = albums["data"] as? JSArray {
                            let album: [Album] = Mapper<Album>().mapArray(JSONArray: datas)
                            completion(.success(album))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
