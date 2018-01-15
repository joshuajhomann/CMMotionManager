//
//  TabViewController.swift
//  CMMotionManger
//
//  Created by Joshua Homann on 1/15/18.
//  Copyright © 2018 com.josh. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    // MARK: - UITabBarController
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NotificationCenter.default.post(name: .tabBarSelected, object: nil)
    }

    deinit {
    }
}
