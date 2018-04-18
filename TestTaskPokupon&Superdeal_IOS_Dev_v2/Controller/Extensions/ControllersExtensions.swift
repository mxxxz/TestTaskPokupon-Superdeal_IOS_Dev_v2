//
//  ControllersExtensions.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 17.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//
import UIKit
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //DUCT TAPE
        if Service.RowCount > 30{
            return 30
        }else{
            return Service.RowCount
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReposCell", for: indexPath) as! SearchTableViewCell
        let reposArray = Service.RepositoriesData[indexPath.row]

        
        cell.NumberOfRepository?.text = String(indexPath.row+1)
        cell.NameOfRepository?.text = String(reposArray.name)
        cell.starsCountLabel?.text = String(reposArray.stargazersCount)
        cell.watchCountLabel?.text = String(reposArray.watchersCount)
        
        if ReposIsAdded[indexPath.row] {
            cell.FavoritesButton.setTitle("✓", for: .normal)
            cell.FavoritesButton.isEnabled = false
        }else{
            cell.FavoritesButton.setTitle("+", for: .normal)
            cell.FavoritesButton.isEnabled = true
        }
        
        return cell
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritesData.count == 0{
            tableView.isHidden = true
            noFavorites.isHidden = false
            
        }else{
            tableView.isHidden = false
            noFavorites.isHidden = true
        }
        return favoritesData.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.deleteObject(obj: favoritesData[indexPath.row])
            favoritesData.remove(at: indexPath.row)
            tableView.reloadData()
            
            tabBar.badgeValue = String(favoritesData.count)
            
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        let saveArray = favoritesData[indexPath.row]
        
        cell.nameOfRepos.text = saveArray.reposName
        cell.userName.text = saveArray.userName
        cell.watchCount.text = String(saveArray.watchCount)
        cell.starCount.text = String(saveArray.starCount)
        cell.forkCount.text = String(saveArray.forkCount)
        
        return cell
    }
    
}
