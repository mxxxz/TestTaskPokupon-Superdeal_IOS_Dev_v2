//
//  ViewController.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 11.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit
//Array from CD
var favoritesData: [FavoritesRepositories] = []
//Service Link
let Service: GitHubService = GitHubService()
class SearchViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    //---------------------SEARCH
    //Search Result
    var searchContext:String = ""
    //Search Bar Setup
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Close preview
        PreviewLogo.isHidden = true
        PreviewLabel.isHidden = true
        //Start animating AI
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        //User Input
        searchContext = searchBar.text!
        //Use handler for get data
        ServiceHandler(UserName: searchContext)
        
        
        //TESTS
        CoreDataManager.fetchResultControllerFunc { (result: Bool) in
            if result{
                DuplicationDataController.nameSearch(userName: self.searchContext)
            }
        }
        
    }
    //--------------------Preview
    @IBOutlet weak var PreviewLogo: UIImageView!
    @IBOutlet weak var PreviewLabel: UILabel!
    //Activity Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!{
        didSet{
            activityIndicator.isHidden = true
        }
    }
    
    //User Information Outlets
    @IBOutlet weak var UserInformationView: UIView!
    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var UserLogin: UILabel!
    
    @IBOutlet weak var UserRepositoriesCount: UILabel!
    @IBOutlet weak var UserFollowersCount: UILabel!
    //-------------------Image Setup
    
    fileprivate var imageUrl: URL?
    
    fileprivate var image: UIImage? {
        get {
            return UserImageView.image
        }
        set {
            UserImageView.image = newValue
            //Change the form of imageView
            UserImageView.layer.cornerRadius = 15
            UserImageView.clipsToBounds = true
        }
    }
    fileprivate func fetchImage() {
        //Create Queue for image
        let imageQueue = DispatchQueue.global(qos: .default)
        imageQueue.async {
            guard let url = self.imageUrl, let imageData = try? Data(contentsOf: url) else {return}
            //after in main Thread
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
    //-------------------ERROR OUTLETS
    //User not found outlet
    @IBOutlet weak var UserNotFoundLabel: UILabel!
    //No repositorie outlet
    @IBOutlet weak var NoRepositorie: UILabel!
    
    //--------------------SERVICE WORK
    func ServiceHandler(UserName: String) {
        //Close the all elem
        NoRepositorie.isHidden = true
        UserNotFoundLabel.isHidden = true
        UserInformationView.isHidden = true
        tableView.isHidden = true
        
        Service.findUserInformation(UserName: UserName) { (result: Bool) in
            if result{
                //get image
                let localImageUrl = Service.UserInfoArray[0]
                self.self.imageUrl = URL(string: localImageUrl)
                self.fetchImage()
                //Use main Thread for UI
                DispatchQueue.main.async {
                    //----------------
                    self.UserLogin.text? = Service.UserInfoArray[1].capitalized
                    self.UserRepositoriesCount.text = "Repositories: \(Service.RowCount)"
                    self.UserFollowersCount.text = Service.UserInfoArray[2]
                    //Show user info view
                    self.UserInformationView.isHidden = false
                }
                //Work with Repos Info
                if Service.RowCount != 0{
                    Service.findRepositoriesInfo(UserName: UserName, completion: { (result: Bool) in
                        if result{
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
//                                Activity Indicator setup
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                self.tableView.isHidden = false
                            }
                            //Create count of this array
                            ReposIsAdded.removeAll()
                            DuplicationDataController.createControllArray()
                            DuplicationDataController.changeControllArray()
                        }
                    })
                }else{
                    DispatchQueue.main.async {
                        //Activity Indicator setup
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.NoRepositorie.isHidden = false
                    }
                }
            }else{
                //USER NOT FOUND BLOCK
                DispatchQueue.main.async {
                    //AI
                    self.activityIndicator.stopAnimating()
                    self.self.activityIndicator.isHidden = true
                    //-----------------------
                    self.UserInformationView.isHidden = true
                    self.UserNotFoundLabel.isHidden = false
                }
            }
        }
    }
    
    //TABLEVIEW
    @IBOutlet weak var tableView: UITableView!
 
    //TABLE VIEW CELL
    //Add in favorites
    @IBAction func FavoritesAction(_ sender: UIButton) {
        //✓ or +
        if let cell = sender.superview?.superview?.superview as? SearchTableViewCell {
            let indexPath = tableView.indexPath(for: cell)
            let reposElemGet = Service.RepositoriesData[indexPath![1]]
            cell.FavoritesButton.setTitle("✓", for: .normal)
            cell.FavoritesButton.isEnabled = false

            CoreDataManager.saveObject(reposUrl: reposElemGet.svnUrl, userName: Service.UserInfoArray[1].capitalized, watchCount: Int16(reposElemGet.watchersCount), starCount: Int16(reposElemGet.stargazersCount), forkCount: Int16(reposElemGet.forksCount), reposName: reposElemGet.name)
            CoreDataManager.fetchResultControllerFunc { (result: Bool) in
                if result{
                    DuplicationDataController.nameSearch(userName: self.searchContext)
                    ReposIsAdded = []
                    DuplicationDataController.createControllArray()
                    DuplicationDataController.changeControllArray()
                }
            }
        }
    }
    override func viewDidLoad() {
        //Protocols
        tableView.dataSource = self
        tableView.delegate = self
        //SearchBar
        searchBar.delegate = self
        super.viewDidLoad()
        
        //Change Search Bar text color
        let test = searchBar.value(forKey: "searchField") as? UITextField
        test?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    //GLOBAL SEPUT
    //Close keyboard after use
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
