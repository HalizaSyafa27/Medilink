//
//  MyTodayAdmissionDischargeTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/12/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class MyTodayAdmissionDischargeTableViewCell: UITableViewCell {
    
    @IBOutlet var lblPatientName: UILabel!
    @IBOutlet var lblPolicyNo: UILabel!
    @IBOutlet var lblProviderId: UILabel!
    @IBOutlet var lblProviderName: UILabel!
    @IBOutlet var lblAdmissionDate: UILabel!
    @IBOutlet var lblGLStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
