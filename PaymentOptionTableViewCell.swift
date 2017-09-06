//
//  PaymentOptionTableViewCell.swift
//  DartApp
//
//  Created by Ally Mahmoud on 9/6/17.
//  Copyright © 2017 Ally Mahmoud. All rights reserved.
//

import UIKit

class PaymentOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
