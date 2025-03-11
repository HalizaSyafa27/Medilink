
//
//  DependentTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 13/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class DependentTableViewCell: UITableViewCell {

    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button1widthConstraint: NSLayoutConstraint!
    @IBOutlet var button2widthConstraint: NSLayoutConstraint!
    @IBOutlet var viewArrow: UIView!
    @IBOutlet var imgViewUser: UIImageView!
    @IBOutlet var lblMemberSince: UILabel!
    @IBOutlet var viewProfile: UIView!
    @IBOutlet var viewProfileHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.button1.layer.cornerRadius = 3
        self.button1.clipsToBounds = true
        self.button2.layer.cornerRadius = 3
        self.button2.clipsToBounds = true
        
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.height/2
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.width/2
        self.imgViewUser.layer.borderWidth = 1.5
        self.imgViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewUser.clipsToBounds = true
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
