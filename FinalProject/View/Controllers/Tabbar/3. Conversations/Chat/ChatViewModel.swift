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

final class ChatViewModel: ViewModel {
    
    // MARK: - Properties
    var messages: [Message] = []
    private let db = Firestore.firestore()
    var sender: User = User(email: "", name: "", id: "")
    var nameSender: String = ""
    var idReceiver: String = ""
    
    // MARK: - Funtions
    func numberOfItems(inSection section: Int) -> Int {
        return messages.count
    }
    
    func getMessageForIndexPaht(atIndexPath indexPath: IndexPath) -> MessageCellViewModel? {
        guard 0 <= indexPath.row && indexPath.row < messages.count else {
            return nil
        }
        
        return MessageCellViewModel(body: messages[indexPath.row].body, isOwner: messages[indexPath.row].isOwner)
    }
    
    func loadMessages(completion: @escaping APICompletion) {
        self.db.collection(Session.shared.idCurrentUser).getDocuments { [weak self] (query, _) in
            guard let query = query, let this = self else {
                return
            }
            for index in query.documents where index.documentID == this.idReceiver {
                this.db.collection(Session.shared.idCurrentUser).document(this.idReceiver).collection("sms").order(by: "date").addSnapshotListener { (querySnapshot, error) in
                    if !this.messages.isEmpty {
                        guard let data = querySnapshot?.documents.last?.data() else { return }
                        if let messageBody = data["body"] as? String,
                            let sender = data["sender"] as? String {
                            if sender == this.idReceiver {
                                let newMessage = Message(isOwner: false, body: messageBody)
                                this.messages.append(newMessage)
                            } else {
                                let newMessage = Message(isOwner: true, body: messageBody)
                                this.messages.append(newMessage)
                            }
                        }
                    } else {
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            if let snapshotDocuments = querySnapshot?.documents {
                                for doc in snapshotDocuments {
                                    let data = doc.data()
                                    if let messageBody = data["body"] as? String,
                                        let sender = data["sender"] as? String {
                                        if sender == this.idReceiver {
                                            let newMessage = Message(isOwner: false, body: messageBody)
                                            this.messages.append(newMessage)
                                        } else {
                                            let newMessage = Message(isOwner: true, body: messageBody)
                                            this.messages.append(newMessage)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success)
                        return
                    }
                }
                this.db.collection(this.idReceiver).document(Session.shared.idCurrentUser).collection("sms").order(by: "date").addSnapshotListener { (querySnapshot, error) in
                    if !this.messages.isEmpty {
                        guard let data = querySnapshot?.documents.last?.data() else { return }
                        if let messageBody = data["body"] as? String,
                            let sender = data["sender"] as? String {
                            if sender == this.idReceiver {
                                let newMessage = Message(isOwner: false, body: messageBody)
                                this.messages.append(newMessage)
                            } else {
                                let newMessage = Message(isOwner: true, body: messageBody)
                                this.messages.append(newMessage)
                            }
                        }
                    } else {
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            if let snapshotDocuments = querySnapshot?.documents {
                                for doc in snapshotDocuments {
                                    let data = doc.data()
                                    if let messageBody = data["body"] as? String,
                                        let sender = data["sender"] as? String {
                                        if sender == this.idReceiver {
                                            let newMessage = Message(isOwner: false, body: messageBody)
                                            this.messages.append(newMessage)
                                        } else {
                                            let newMessage = Message(isOwner: true, body: messageBody)
                                            this.messages.append(newMessage)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success)
                    }
                }
            }
        }
    }
    
    func postMessageToFirebase(body: String, completion: @escaping FBCompletion) {
        self.db.collection(Session.shared.idCurrentUser).getDocuments { [weak self] (query, _) in
            guard let query = query, let this = self else { return }
            for index in query.documents {
                if let data = index.data()["id"] as? String {
                    if this.idReceiver == data {
                        this.db.collection(Session.shared.idCurrentUser).document(this.idReceiver).collection("sms").addDocument(data: [
                            "sender": Session.shared.idCurrentUser,
                            "body": body,
                            "date": Date().timeIntervalSince1970])
                        completion(.success)
                        return
                    }
                }
            }
            this.db.collection(this.idReceiver).document(Session.shared.idCurrentUser).collection("sms").addDocument(data: [
                "sender": Session.shared.idCurrentUser,
                "body": body,
                "date": Date().timeIntervalSince1970])
            this.db.collection(this.idReceiver).document(Session.shared.idCurrentUser).setData([
                "id": Session.shared.idCurrentUser])
            this.db.collection(Session.shared.idCurrentUser).document(this.idReceiver).setData([
                "isConnected": true])
            completion(.success)
        }
        completion(.failure)
    }
}
