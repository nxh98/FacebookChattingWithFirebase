//
//  FriendsProfileViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM

final class FriendsProfileViewModel: ViewModel {
    
    var albums: [Album] = []
    var nameUser: String = ""
    var detailFriend: DetailsFriend? {
        didSet {
            if detailFriend?.gender == "male" {
                detailFriend?.gender = "Nam"
            }
            if detailFriend?.gender == "female" {
                detailFriend?.gender = "Nữ"
            }
        }
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return albums.count
    }
    
    func getAlbumForCell(atIndexPath indexPath: IndexPath) -> AlbumCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < albums.count else { return nil }
        return AlbumCellViewModel(image: albums[indexPath.row].coverPhoto, name: albums[indexPath.row].name)
    }
    
    func getDetailFriend(completion: @escaping APICompletion) {
        Api.DetailUser.getDetailUser { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let res):
                guard let res = res as? DetailsFriend else { return }
                this.detailFriend = res
                completion(.success)
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getAllAlbum(completion: @escaping APICompletion) {
        Api.DetailUser.getAllAlbum { [weak self] result in
        guard let this = self else { return }
            switch result {
            case .success(let res):
                guard let res = res as? [Album] else { return }
                    this.albums = res
                    completion(.success)
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
