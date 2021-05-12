//
//  FriendsCollectionViewCell.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class FriendsCell: UICollectionViewCell {

    // MARK: - @IBOutlet
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var nameCell: UILabel!
    @IBOutlet private weak var maskNameLabel: UIView!
    
    var viewModel: FriendsCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.imageCell.layer.cornerRadius = 10
            self.maskNameLabel.roundCorners([.bottomLeft, .bottomRight], radius: 10)
            self.nameCell.roundCorners([.bottomLeft, .bottomRight], radius: 10)
        }
    }

    private func updateView() {
        nameCell.text = viewModel?.name
        imageCell.setImage(urlString: viewModel?.image, placeholderImage: #imageLiteral(resourceName: "no-image"))
    }
}
