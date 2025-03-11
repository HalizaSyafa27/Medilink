//
//  ListCoverageTableViewCell.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 20/03/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class ListCoverageTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblCoverage: UILabel!
    @IBOutlet weak var widthArrowRightConstraints: NSLayoutConstraint!
    @IBOutlet weak var viewNextPage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
