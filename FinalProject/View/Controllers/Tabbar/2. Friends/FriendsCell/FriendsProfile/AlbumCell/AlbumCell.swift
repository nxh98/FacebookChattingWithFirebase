//
//  AlbumCell.swift
//  FinalProject
//
//  Created by NXH on 10/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var nameAlbumLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: AlbumCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
        imageCell.layer.borderColor = UIColor.black.cgColor
        imageCell.layer.borderWidth = 0.5
    }
    
    // MARK: - Private function
    private func updateView() {
        nameAlbumLabel.text = viewModel?.nameAlbum
        imageCell.setImage(urlString: viewModel?.imageCell, placeholderImage: #imageLiteral(resourceName: "no-image"))
    }
}
