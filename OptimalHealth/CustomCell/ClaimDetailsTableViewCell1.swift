//
//  ClaimDetailsTableViewCell1.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 26/07/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class ClaimDetailsTableViewCell1: UITableViewCell {

    @IBOutlet var viewWithDischargeDate: UIView!
    @IBOutlet var viewWithOutDischargeDate: UIView!
    
    @IBOutlet var labelWithOutDischargeDate1: UILabel!
    @IBOutlet var labelWithOutDischargeDate1Header: UILabel!
    @IBOutlet var labelWithOutDischargeDate2: UILabel!
    @IBOutlet var labelWithOutDischargeDate2Header: UILabel!
    
    @IBOutlet var lblClaimId: UILabel!
    @IBOutlet var lblAdmissionDateHeader: UILabel!
    @IBOutlet var lblAdmissionDate: UILabel!
    @IBOutlet var lblDischargeDate: UILabel!
    @IBOutlet var lblDischargeDateHeader: UILabel!
    @IBOutlet var lblTotalBill: UILabel!
    @IBOutlet weak var lblTotalBillTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
