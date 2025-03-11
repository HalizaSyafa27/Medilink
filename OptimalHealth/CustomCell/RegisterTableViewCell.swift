//
//  RegisterTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 15/04/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    @IBOutlet var imgViewcheckBox: UIImageView!
    @IBOutlet var lblTermsCond: UILabel!
    @IBOutlet var btnTermsCond: UIButton!
    @IBOutlet var btnRegisterNow: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnRegisterNow.layer.cornerRadius = btnRegisterNow.frame.size.height / 2
        btnRegisterNow.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
