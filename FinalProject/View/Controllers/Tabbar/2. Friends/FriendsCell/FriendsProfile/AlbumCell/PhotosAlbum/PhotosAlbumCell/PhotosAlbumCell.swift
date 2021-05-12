//
//  PhotosAlbumCell.swift
//  FinalProject
//
//  Created by NXH on 10/5/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PhotosAlbumCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    var viewModel: PhotosAlbumCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateView() {
        imageCell.setImage(urlString: viewModel?.image, placeholderImage: #imageLiteral(resourceName: "no-image"))
    }

}
