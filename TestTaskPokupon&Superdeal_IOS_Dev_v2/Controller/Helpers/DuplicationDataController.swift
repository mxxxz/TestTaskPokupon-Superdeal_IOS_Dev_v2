//
//  DuplicationDataController.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 18.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import Foundation
//Dupl repos names
var DUPLICATEREPOSARRAY = [String]()
//User Cells
var CellIndexAdded = [Int]()
//Repos is added array
var ReposIsAdded = [Bool]()

class DuplicationDataController{
    class func nameSearch(userName: String) {
        DUPLICATEREPOSARRAY.removeAll()
        if favoritesData.count != 0 {
            for index in 0..<(favoritesData.count){
                let localArray = favoritesData[index]
                if userName == localArray.userName.lowercased() {
                    DUPLICATEREPOSARRAY.append(localArray.reposName)
                }
            }
        }
    }
    class func createControllArray(){
        for i in 0..<(Service.RepositoriesData.count){
            ReposIsAdded.append(false)
        }
    }
    class func changeControllArray(){
        for i in 0..<(Service.RepositoriesData.count){
            for j in 0..<(DUPLICATEREPOSARRAY.count){
                if Service.RepositoriesData[i].name == DUPLICATEREPOSARRAY[j] {
                    ReposIsAdded[i] = true
                }
            }
        }
    }
}
