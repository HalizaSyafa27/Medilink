//
//  RatingByProviderTableViewCell.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 27/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class RatingByProviderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var lblPublishDate: UILabel!
    @IBOutlet weak var lblRemarks: UILabel!
    @IBOutlet weak var imgsView: UIView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var HeightConstraintImages: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

