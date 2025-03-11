//
//  ViewGlLetterListTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/06/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class ViewGlLetterListTableViewCell: UITableViewCell {
    
    @IBOutlet var lblAdmissionDate: UILabel!
    @IBOutlet var lblCoverageId: UILabel!
    @IBOutlet var lblPatientName: UILabel!
    @IBOutlet var lblClaimId: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var imgViewStatus: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
