//
//  NameAndPictureTableViewCell.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/3/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class NameAndPictureTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.backgroundColor = UIColor.lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
