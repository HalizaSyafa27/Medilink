//
//  AccountTypeTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class AccountTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgViewMedilinkMember: UIImageView!
    @IBOutlet weak var imgViewNonMedilinkMember: UIImageView!
    @IBOutlet var btnUserType: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

