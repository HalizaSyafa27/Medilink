//
//  VirtualCardTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 06/02/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class VirtualCardTableViewCell: UITableViewCell {

    @IBOutlet weak var imgeViewUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberSince: UILabel!
    @IBOutlet var imgViewArrowRight: UIImageView!
    @IBOutlet var imgViewVirtualCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.imgeViewUser.layer.cornerRadius = self.imgeViewUser.frame.height/2
        self.imgeViewUser.layer.cornerRadius = self.imgeViewUser.frame.width/2
        self.imgeViewUser.layer.borderWidth = 1.5
        self.imgeViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgeViewUser.clipsToBounds = true

       
    }

}
