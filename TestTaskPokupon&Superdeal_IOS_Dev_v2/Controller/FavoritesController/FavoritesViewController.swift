//
//  FavoritesViewController.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 14.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit
import CoreData

var currentSvnUrl: String = ""
class FavoritesViewController: UIViewController,UITableViewDelegate{

    //Clear Core Data Model
    func deleteContent(completion: (_ result: Bool) -> Void) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let coord = appDel.persistentContainer.persistentStoreCoordinator

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesRepositories")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try coord.execute(deleteRequest, with: context)
            completion(true)
        }catch let error as NSError {
            debugPrint(error)
        }
    }
    @IBAction func DeleteAll(_ sender: UIButton) {
        deleteContent { (result: Bool) in
            if result{
                DispatchQueue.main.async {
                    favoritesData.removeAll()
                    self.tableView.reloadData()
                    //Remove tabBarItemCount
                    self.tabBar.badgeValue = String(0)
                }
                DUPLICATEREPOSARRAY = []
                ReposIsAdded = []
                DuplicationDataController.createControllArray()
            }
        }
    }
    
    override func viewDidLoad() {
        //Protocols
        //Table view
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }
    //TABBAR
    @IBOutlet weak var tabBar: UITabBarItem!
    //NET
    @IBAction func URLButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? FavoritesTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            let arrayIndex = favoritesData[indexPath![1]]
            currentSvnUrl = arrayIndex.reposUrl
        }
    }
    //TABLE VIEW
    @IBOutlet weak var tableView: UITableView!
//---
    //NO FAVORITES outlet
    @IBOutlet weak var noFavorites: UILabel!
    
//---
    //GLOBAL SETUP
    //Close keyboard after use
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
