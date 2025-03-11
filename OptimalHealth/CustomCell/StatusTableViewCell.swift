//
//  StatusTableViewCell.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/22/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    @IBOutlet var lblTitleReqDate: UILabel!
    @IBOutlet var GLRequestIdLbl: UILabel!
    @IBOutlet var requestDateLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    @IBOutlet var remarksLbl: UILabel!
    @IBOutlet var GLClaimNoLbl: UILabel!
    @IBOutlet var lblRemarksTitle: UILabel!
    @IBOutlet var lblRemarksTitleWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
