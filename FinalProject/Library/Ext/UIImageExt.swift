//
//  UIImageExt.swift
//  FinalProject
//
//  Created by NXH on 10/14/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(urlString: String?, placeholderImage: UIImage?, options: SDWebImageOptions = [.continueInBackground, .retryFailed], completion: ((UIImage?, String?) -> Void)? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: options) { (image, _, _, url) in
            DispatchQueue.main.async {
                completion?(image, url?.absoluteString)
            }
        }
    }
}
