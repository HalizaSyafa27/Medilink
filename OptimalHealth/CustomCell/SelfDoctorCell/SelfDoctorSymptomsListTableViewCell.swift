//
//  SelfDoctorSymptomsListTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class SelfDoctorSymptomsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblSymptomsName: UILabel!
    @IBOutlet weak var lblCommon: UILabel!
    @IBOutlet weak var lblCommonWidthConstraints: NSLayoutConstraint!
    @IBOutlet weak var imgViewRedFlagIcon: UIImageView!
    @IBOutlet weak var imgViewIconWidthConstraints: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblCommon.layer.cornerRadius = 12
        lblCommon.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
