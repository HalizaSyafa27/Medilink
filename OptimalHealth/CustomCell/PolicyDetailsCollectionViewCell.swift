//
//  PolicyDetailsCollectionViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 31/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class PolicyDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblPolicyCode: UILabel!
    @IBOutlet var lblPlanCode: UILabel!
    @IBOutlet var lblPlanName: UILabel!
    @IBOutlet var lblPlanVersion: UILabel!
    @IBOutlet var lblPolicyCodeHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPlanVersionHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPolicyOrPlanVersion: UILabel!
    @IBOutlet var lblPolicyOrPlanVersionHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
