//
//  MenuTableViewCell.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/3/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
