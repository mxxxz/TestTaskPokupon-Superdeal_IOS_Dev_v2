//
//  FavoritesCountHelper.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 17.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit
class FavoritesCountHelper {
    class func favoritesCount() -> Int{
        return favoritesData.count
    }
    class func changeBadgeValue(VC: UIViewController) {
        VC.tabBarItem.badgeValue = String(favoritesCount())
    }
}
