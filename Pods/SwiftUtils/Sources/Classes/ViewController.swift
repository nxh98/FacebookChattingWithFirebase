//
//  ViewController.swift
//  SwiftUtils
//
//  Created by DaoNV on 12/31/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

open class ViewController: UIViewController {
    open fileprivate(set) var isViewDidAppear = false
    open fileprivate(set) var isViewFirstAppear = false

    public override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    open func setup() {
        automaticallyAdjustsScrollViewInsets = false
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        isViewFirstAppear = true
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isViewDidAppear = true
        DispatchQueue.main.async { [weak self] in
            self?.isViewFirstAppear = false
        }
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isViewDidAppear = false
    }
}
