//
//  ReceiverCell.swift
//  FinalProject
//
//  Created by NXH on 9/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class ReceiverCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet private weak var smsLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    var viewModel: MessageCellViewModel? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    // MARK: - Private Functions
    private func configUI() {
        containerView.cornerRadius = 10
    }
    
    private func updateView() {
        smsLabel.text = viewModel?.body
    }
}
