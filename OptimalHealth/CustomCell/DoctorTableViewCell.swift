//
//  DoctorTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 27/05/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblMobile: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblstatusColor: UILabel!
    @IBOutlet var imgViewDoctor: UIImageView!
    @IBOutlet var btnConnect: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initdesign()
    }
    
    func initdesign(){
        imgViewDoctor.layer.cornerRadius = imgViewDoctor.frame.size.height / 2
        imgViewDoctor.clipsToBounds = true
        
        lblstatusColor.layer.cornerRadius = lblstatusColor.frame.size.height / 2
        lblstatusColor.clipsToBounds = true
        
        btnConnect.layer.cornerRadius = 5
        btnConnect.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
