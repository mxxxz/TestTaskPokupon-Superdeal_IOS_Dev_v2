//
//  UserRepositoriesModel.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 11.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import Foundation
struct RepositoriesInfo: Decodable {
    let name: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let svnUrl: String
}
