//
//  ClaimsFormTableViewCell.swift
//  OptimalHealth
//
//  Created by Dinh Van Tin on 13/09/2022.
//  Copyright © 2022 Oditek. All rights reserved.
//

import UIKit

class ClaimsFormTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewMenu: UIImageView!
    @IBOutlet weak var lblMenuTitle: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
