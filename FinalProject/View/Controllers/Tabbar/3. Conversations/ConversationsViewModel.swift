//
//  ConversationsViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM
import FirebaseFirestore
import RealmSwift

final class ConversationsViewModel: ViewModel {
    
    var friends: [Friends] = []
    var user: User?
    
    func numberOfItems(inSection section: Int) -> Int {
        return friends.count
    }
    
    func getFriendForIndexPath(atIndexPath indexPath: IndexPath) -> ConversationsCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < friends.count else {
            return nil
        }
        return ConversationsCellViewModel(name: friends[indexPath.row].name, image: friends[indexPath.row].image, id: friends[indexPath.row].id)
    }
    
    func fetchData(completion: (Bool) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(Friends.self)
            friends = Array(results)
            completion(true)
        } catch {
            completion(false)
        }
    }
}
