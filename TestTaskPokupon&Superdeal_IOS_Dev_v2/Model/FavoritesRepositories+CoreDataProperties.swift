//
//  FavoritesRepositories+CoreDataProperties.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 17.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritesRepositories {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<FavoritesRepositories> {
        return NSFetchRequest<FavoritesRepositories>(entityName: "FavoritesRepositories")
    }

    @NSManaged public var forkCount: Int16
    @NSManaged public var reposName: String
    @NSManaged public var reposUrl: String
    @NSManaged public var starCount: Int16
    @NSManaged public var userName: String
    @NSManaged public var watchCount: Int16

}
