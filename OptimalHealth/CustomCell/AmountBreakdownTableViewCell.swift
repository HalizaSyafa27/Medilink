//
//  AmountBreakdownTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 26/06/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class AmountBreakdownTableViewCell: UITableViewCell {
    
    @IBOutlet var lblProviderName: UILabel!
    @IBOutlet var lblClaimId: UILabel!
    @IBOutlet var lblAdmDate: UILabel!
    @IBOutlet var lblDiagnosis: UILabel!
    @IBOutlet var lblDueTotal: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
