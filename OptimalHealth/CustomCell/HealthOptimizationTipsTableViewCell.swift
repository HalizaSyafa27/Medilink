//
//  HealthOptimizationTipsTableViewCell.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 11/22/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class HealthOptimizationTipsTableViewCell: UITableViewCell {
    
    @IBOutlet var lblHealthTipsTitle: UILabel!
    @IBOutlet var lblHealthTipsDesc: UILabel!
    @IBOutlet var imgViewHealthTips: UIImageView!
    @IBOutlet var btnMore: UIButton!
    @IBOutlet var imgViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
