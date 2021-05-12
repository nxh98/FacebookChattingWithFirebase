//
//  Router.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire

final class Api {
    struct Path {
        static let domain = "https://graph.facebook.com"
        static let baseURL = domain / "v8.0"
    }
    
    struct DetailUser {}
    struct InforUser {}
    struct PhotosInAlbum {}
}

extension Api.Path {
    
    struct InforUser {
        static let userID: String = "me"
        static let fieldUser: String = "email,name"
        static var userPath: String {
            return Api.Path.baseURL / "\(userID)?fields=\(fieldUser)&access_token=\(Session.shared.accessToken)"
        }
        static let fieldFriends: String = "friends?fields=name,picture.width(480).height(480)"
        static var allFriendPath: String {
            return Api.Path.baseURL / "\(userID)/\(fieldFriends)&access_token=\(Session.shared.accessToken)"
        }
    }
    
    struct DetailUser {
        static var userID: String {
            return Session.shared.idFriend }
        static let fieldUser: String = "friends,picture.width(480).height(480),quotes,birthday,email,hometown,name,address,gender,location,albums.fields(name,cover_photo.fields(source))"
        static var path: String {
            return Api.Path.baseURL / "\(userID)?fields=\(fieldUser)&access_token=\(Session.shared.accessToken)"
        }
        
        static let fieldsAlbum: String = "albums.fields(name,cover_photo.fields(source))"
        static var albumPath: String {
            return Api.Path.baseURL / "\(userID)?fields=\(fieldsAlbum)&access_token=\(Session.shared.accessToken)"
        }
    }
    
    struct PhotosInAlbum {
        static var albumID: String {
            return Session.shared.idAlbum
        }
        static var nextToken: String = ""
        static var fields: String {
            return"/photos?fields=name,source,likes.summary(true)&limit=24&after=\(nextToken)"
        }
        static var photosPath: String {
            return Api.Path.baseURL / "\(albumID)\(fields)&access_token=\(Session.shared.accessToken)"
        }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
