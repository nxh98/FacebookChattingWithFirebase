//
//  PhotosAlbumViewModel.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM

final class PhotosAlbumViewModel: ViewModel {
    
    var nameAlbum: String = ""
    var photos: Photos?
    var nextToken: String = ""
    
    func numberOfItems() -> Int {
        guard let count = photos?.photos.count else { return 0 }
        return count
    }
    
    func getPhotosForCell(atIndexPath indexPath: IndexPath) -> PhotosAlbumCellViewModel? {
        guard let photos = photos?.photos else {
            return PhotosAlbumCellViewModel(image: "")
        }
        guard 0 <= indexPath.row && indexPath.row < photos.count else {
            return PhotosAlbumCellViewModel(image: "")
        }
        return PhotosAlbumCellViewModel(image: photos[indexPath.row].image)
    }
    
    func getPhotosInAlbum(completion: @escaping APICompletion) {
        Api.Path.PhotosInAlbum.nextToken = nextToken
        Api.PhotosInAlbum.getPhotosInAlbum { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let data):
                guard let value = data as? Photos else { return }
                if this.photos != nil {
                    if this.nextToken != "" {
                        this.photos?.photos.append(contentsOf: value.photos)
                        this.nextToken = value.nextToken
                    } else {
                        this.nextToken = ""
                    }
                } else {
                    this.photos = value
                    this.nextToken = value.nextToken
                }
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
