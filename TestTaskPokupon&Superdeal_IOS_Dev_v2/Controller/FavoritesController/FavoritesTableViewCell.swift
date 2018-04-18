//
//  FavoritesTableViewCell.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 14.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfRepos: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var watchCount: UILabel!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var forkCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
