//
//  MainTabbarController.swift
//  MVPProduct
//
//  Created by tomoyo_kageyama on 2022/04/06.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }

    func setupTab() {
        // fixme: そのうち対応する
        let firstViewController = ContentViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Featured", image: UIImage(systemName: "star.fill"), tag: 0)

        let contentViewController = ContentViewController()
        contentViewController.tabBarItem = UITabBarItem(title: "Landmarks", image: UIImage(systemName: "list.bullet"), tag: 1)

        viewControllers = [firstViewController, contentViewController]
    }
}
