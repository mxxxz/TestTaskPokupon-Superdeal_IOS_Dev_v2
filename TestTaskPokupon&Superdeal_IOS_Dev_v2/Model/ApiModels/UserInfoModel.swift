//
//  UserInformationModel.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 11.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import Foundation
struct UserInformationStruct: Decodable{
    let login: String
    let avatarUrl: String
    let followers: Int
    let publicRepos: Int
}
