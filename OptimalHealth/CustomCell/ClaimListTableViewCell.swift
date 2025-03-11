//
//  ClaimListTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class ClaimListTableViewCell: UITableViewCell {
    
    @IBOutlet var lblClaimId: UILabel!
    @IBOutlet var lblCoverageId: UILabel!
    @IBOutlet var lblDateHeader: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblProviderNameHeader: UILabel!
    @IBOutlet var lblProviderName: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var starIconView: UIView!
    @IBOutlet weak var starViewConstraintHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
