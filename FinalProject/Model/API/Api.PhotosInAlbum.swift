//
//  Api.PhotosInAlbum.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import ObjectMapper

extension Api.PhotosInAlbum {
    
    @discardableResult
    static func getPhotosInAlbum(completion: @escaping Completion) -> Request? {
        let path = Api.Path.PhotosInAlbum.photosPath
        return api.request(method: .get, urlString: path, parameters: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let json = data as? JSObject, let datas = json["data"] as? JSArray {
                        let photo: [Photo] = Mapper<Photo>().mapArray(JSONArray: datas)
                        guard var photos = Mapper<Photos>().map(JSON: json) else { return }
                        photos.photos = photo
                        completion(.success(photos))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
