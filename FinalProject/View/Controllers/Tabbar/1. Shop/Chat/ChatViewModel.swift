//
//  ChatViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM
import FirebaseFirestore
import Firebase

final class ChatViewModel: ViewModel {
    
     var messages: [Message] = []
    let db = Firestore.firestore()
    
    func numberOfItems(inSection section: Int) -> Int {
        return messages.count
    }
    
    func getMessageForIndexPaht(atIndexPath indexPath: IndexPath) -> SenderCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < messages.count else {
            return nil
        }
        return SenderCellViewModel(body: messages[indexPath.row].body)
    }
    
    func loadMessagesOnTableView(tableView: UITableView) {
        db.collection().order(by: "date").addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let _ = error {
                return
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                tableView.reloadData()
                let indexPath = IndexPath(row: self.numberOfItems(inSection: 0) - 1, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    func postMessageToFirebase(body: String) {
         if let sender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": sender,
                "body": body,
                "date": Date().timeIntervalSince1970
            ]) { error in
                if let _ = error {
                    return
                }
            }
        }
    }
}
