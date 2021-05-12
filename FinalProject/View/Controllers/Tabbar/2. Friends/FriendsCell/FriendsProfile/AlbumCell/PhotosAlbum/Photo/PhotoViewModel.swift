//
//  PhotoViewModel.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import MVVM

final class PhotoViewModel: ViewModel {
    
    var index: Int = 0
    var photos: Photos?
    
    func numberOfItems(inSection section: Int) -> Int {
        guard let photos = photos?.photos else {
            return 0
        }
        return photos.count
    }
    
    func getPhotoForCell(atIndexPath indexPath: IndexPath) -> PhotoCellViewModel? {
        guard let photos = photos?.photos else { return nil }
        guard 0 <= indexPath.row && indexPath.row < photos.count else {
            return nil
        }
        return PhotoCellViewModel(photo: (photos[indexPath.row]))
    }
}
