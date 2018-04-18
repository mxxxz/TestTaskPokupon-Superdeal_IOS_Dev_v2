//
//  GitHubService.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 11.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import Foundation
class GitHubService{
    //Default Array for user information
    var UserInfoArray = [String]()
    //Variable for Rows in tableViewCell
    var RowCount: Int = 0
    
    //DECODER
    let decoder = JSONDecoder()
    
    //Find Personal User Info
    func findUserInformation(UserName: String, completion: @escaping (_ result:Bool) -> Void){
        let UserInformationQueue = DispatchQueue(label: "UserInfo", qos: .utility, attributes: .concurrent)
        UserInformationQueue.async {
            self.UserInfoArray.removeAll()
            
            //URL
            let jsonUrlString = "https://api.github.com/users/\(UserName)"
            guard let url = URL(string: jsonUrlString) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                //perhaps checkerr
                //also perhaps check response status 200 OK
                guard let data = data else {return}
                do {
                    //Convertation snake in camel
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let local = try self.decoder.decode(UserInformationStruct.self, from: data)
                    //Information append
                    self.UserInfoArray.append(local.avatarUrl)
                    self.UserInfoArray.append(local.login)
                    self.UserInfoArray.append(String(local.followers))
                    //reposCount
                    self.RowCount = local.publicRepos
                    //Download complete
                    //Change status
                    completion(true)
                }catch{
                    //Download failed
                    completion(false)
                }
            }.resume()
        }
    }
    
    //REPOSITORIES
    var RepositoriesData = [RepositoriesInfo]()
    //Find Repositories Info
    func findRepositoriesInfo(UserName: String, completion: @escaping (_ result: Bool) -> Void){
        let repositoriesQueue = DispatchQueue(label: "RepositoriesQueue", qos: .utility, attributes: .concurrent)
        repositoriesQueue.async {
            //URL
            let jsonUrlString = "https://api.github.com/users/\(UserName)/repos"
            guard let url = URL(string: jsonUrlString) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {return}
                do {
                    //Convertation Snake in Camel
                    self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                    //Get repos data
                    self.RepositoriesData = try self.decoder.decode([RepositoriesInfo].self, from: data)
                    //Download complete
                    completion(true)

                }catch{
                    print("ERROR")
                    //Download failed
                    completion(false)
                }
            }.resume()
        }
    }
    
    
}
