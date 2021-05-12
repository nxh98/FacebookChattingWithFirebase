//
//  TabbarViewController.swift
//  FinalProject
//
//  Created by NXH on 9/21/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class TabbarViewController: UITabBarController {
    
    // MARK: - Properties
    private var friendsNavi: UINavigationController = UINavigationController(rootViewController: FriendsViewController())
    private var conversationsNavi: UINavigationController = UINavigationController(rootViewController: ConversationsViewController())
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
        customTabbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.roundCorners([.topLeft, .topRight], radius: 20)
        tabBar.layer.masksToBounds = true
    }
    
    // MARK: - Private functions
    private func configTabbar() {
        let tabbarItems: [UIViewController] = [friendsNavi, conversationsNavi]
        friendsNavi.tabBarItem = UITabBarItem(title: TabbarItemsKey.Name.friends, image: UIImage(named: TabbarItemsKey.Image.friends), tag: 2)
        conversationsNavi.tabBarItem = UITabBarItem(title: TabbarItemsKey.Name.conversations, image: UIImage(named: TabbarItemsKey.Image.conversations), tag: 3)
        viewControllers = tabbarItems
    }
    
    private func customTabbar() {
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor(hexString: "E74C3C")
        tabBar.unselectedItemTintColor = UIColor(hexString: "CCCCCC")
    }
}

// MARK: - UITabBarControllerDelegate
extension TabbarViewController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let bounceAnimation: CAKeyframeAnimation = {
            let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            bounceAnimation.values = [1.1, 1.2, 1.3, 1.2, 1.1]
            bounceAnimation.duration = TimeInterval(0.2)
            return bounceAnimation
        }()
        guard let index = tabBar.items?.firstIndex(of: item),
            tabBar.subviews.count > index + 1,
            let imageView = tabBar.subviews[index + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
