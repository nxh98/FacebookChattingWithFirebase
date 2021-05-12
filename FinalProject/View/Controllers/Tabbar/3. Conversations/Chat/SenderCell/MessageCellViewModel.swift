//
//  SenderCellViewModel.swift
//  FinalProject
//
//  Created by NXH on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class MessageCellViewModel {
    private(set) var body: String
    private(set) var isOwner: Bool
    
    init(body: String, isOwner: Bool) {
        self.body = body
        self.isOwner = isOwner
    }
}
