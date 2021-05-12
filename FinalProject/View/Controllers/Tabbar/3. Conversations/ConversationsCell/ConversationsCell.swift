//
//  ConversationsCell.swift
//  FinalProject
//
//  Created by NXH on 9/28/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class ConversationsCell: UITableViewCell {

    // MARK: - @IBOutlet
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var nameCell: UILabel!
    
    var viewModel: ConversationsCellViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
        imageCell.layer.cornerRadius = 10
        imageCell.layer.masksToBounds = true
    }

    private func updateView() {
        nameCell.text = viewModel?.name
        imageCell.setImage(urlString: viewModel?.image, placeholderImage: #imageLiteral(resourceName: "no-avatar"))
    }
    
}
