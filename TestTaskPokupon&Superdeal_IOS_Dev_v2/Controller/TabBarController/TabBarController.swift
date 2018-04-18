//
//  TabBarController.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 16.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is FavoritesViewController {
            if let FavoritesVC = viewController as? FavoritesViewController {
                FavoritesVC.tableView.reloadData()
                FavoritesVC.tabBar.badgeValue = String(favoritesData.count)
                print("СРАБОТАЛО!!!!")
            }
        }
    }
}
