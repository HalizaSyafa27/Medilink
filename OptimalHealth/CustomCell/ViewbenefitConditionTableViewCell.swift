//
//  ViewbenefitConditionTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 28/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class ViewbenefitConditionTableViewCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet weak var lblConditionTitle: UILabel!
    @IBOutlet var lblCondition: UILabel!
    @IBOutlet var lblYtdConsumptionTitle: UILabel!
    @IBOutlet var lblYtdConsumption: UILabel!
    @IBOutlet var imgViewArrow: UIImageView!
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewCoverage: UIView!
    @IBOutlet var coverageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var imgViewRightArrow: UIImageView!
    @IBOutlet weak var viewIndividualBalance: UIView!
    @IBOutlet weak var lblIndividualBalance: UILabel!
    @IBOutlet weak var viewNote: UIView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblIndividualBalanceLimitTitle: UILabel!
    @IBOutlet weak var HeightViewIndiConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightViewNoteConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightImageIndiConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightImageNoteConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightViewCoverateConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblLineYtd: UILabel!
    @IBOutlet weak var viewBenefit: UIView!
    @IBOutlet weak var viewBenefitAction: UIImageView!
    @IBOutlet weak var lblBenefit: UILabel!
    @IBOutlet weak var heightViewBenefitConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
