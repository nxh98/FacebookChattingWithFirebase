//
//  PhotoCell.swift
//  FinalProject
//
//  Created by NXH on 10/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var statusTextView: UITextView!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var heightTextView: NSLayoutConstraint!
    
    @IBOutlet private weak var seemoreButton: UIButton!
    @IBOutlet private weak var tempLabel: UILabel!
    var viewModel: PhotoCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    private func configUI() {
         let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnNameLabel))
        statusTextView.addGestureRecognizer(tapGesture)
    }

    private func updateView() {
        guard let photo = viewModel?.photo else { return }
        DispatchQueue.main.async {
            if self.heightTextInTexiView() <= 50 {
                self.heightTextView.constant = self.heightTextInTexiView()
                self.seemoreButton.alpha = 0
                self.tempLabel.alpha = 0
                self.statusTextView.alpha = 1
                    } else {
                self.heightTextView.constant = 50
                self.seemoreButton.alpha = 1
                self.tempLabel.alpha = 1
                self.statusTextView.alpha = 0
                    }
        }
        tempLabel.text = photo.name
        statusTextView.isScrollEnabled = false
        likeLabel.text = "\(photo.likes) \(FacebookKey.likeString)"
        statusTextView.text = "\(photo.name)"
        imageCell.setImage(urlString: photo.image, placeholderImage: #imageLiteral(resourceName: "no-image"))
    }
    
    private func heightTextInTexiView() -> CGFloat {
        let sizeThatFitsTextView = statusTextView.sizeThatFits(CGSize(width: statusTextView.frame.size.width, height: CGFloat()))
        if sizeThatFitsTextView.height > self.height - likeLabel.height - 25 {
            return self.height - likeLabel.height - 25
        }
        return  sizeThatFitsTextView.height
    }
    
    // MARK: - Objc func
    @objc private func tapOnNameLabel() {
        if heightTextInTexiView() > 50 {
        self.heightTextView.constant = 50
        self.statusTextView.isScrollEnabled = false
        self.tempLabel.alpha = 1
        self.seemoreButton.alpha = 1
        self.statusTextView.alpha = 0
        }
    }
    
    @IBAction func seemoreTouchUpInside(_ sender: UIButton) {
            statusTextView.isScrollEnabled = true
            self.heightTextView.constant = self.heightTextInTexiView()
            self.tempLabel.alpha = 0
            self.seemoreButton.alpha = 0
            self.statusTextView.alpha = 1
    }
}
