//
//  AlbumCellViewModel.swift
//  FinalProject
//
//  Created by NXH on 10/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation

final class AlbumCellViewModel {
    private(set) var imageCell: String
    private(set) var nameAlbum: String
    
    init(image: String, name: String) {
        imageCell = image
        nameAlbum = name
    }
}
