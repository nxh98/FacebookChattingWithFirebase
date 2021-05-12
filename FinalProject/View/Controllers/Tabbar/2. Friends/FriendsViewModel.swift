//
//  FriendsViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM

final class FriendsViewModel: ViewModel {
    
    private var friends: [Friends] = []
    var user: User?
    
    func numberOfItems(inSection section: Int) -> Int {
        return friends.count
    }
    
    func getFriends(completion: @escaping APICompletion) {
        Api.InforUser.getAllFriends { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let res):
                guard let res = res as? [Friends] else { return }
                this.friends = res
                completion(.success)
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getUser(completion: @escaping APICompletion) {
        Api.InforUser.getUser { [weak self] result in
        guard let this = self else { return }
            switch result {
            case .success(let res):
                guard let res = res as? User else { return }
                this.user = res
                completion(.success)
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func getFriendForIndexPath(atIndexPath indexPath: IndexPath) -> FriendsCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < friends.count else {
            return nil
        }
        return FriendsCellViewModel(name: friends[indexPath.row].name, image: friends[indexPath.row].image, id: friends[indexPath.row].id)
    }
}
