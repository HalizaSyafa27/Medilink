//
//  WellnessTableViewCell.swift
//  OptimalHealth
//
//  Created by Dinh Van Tin on 15/09/2022.
//  Copyright © 2022 Oditek. All rights reserved.
//

import UIKit

class WellnessTableViewCell: UITableViewCell {

    @IBOutlet var lblFileName: UILabel!
    @IBOutlet var lblFileSize: UILabel!
    @IBOutlet var btnRemove: UIButton!
    @IBOutlet var imgViewAttachment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
