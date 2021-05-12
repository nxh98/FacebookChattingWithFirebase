//
//  RefreshControl.swift
//  SwiftUtils
//
//  Created by DaoNV on 5/7/16.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

open class RefreshControl: UIRefreshControl {

    override open func endRefreshing() {
        let scrollView = superview as? UIScrollView
        let scrollEnabled = scrollView?.isScrollEnabled ?? true
        scrollView?.isScrollEnabled = false
        super.endRefreshing()
        scrollView?.isScrollEnabled = scrollEnabled
    }

}
