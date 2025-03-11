//
//  MedilinkMemberTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class MedilinkMemberTableViewCell: UITableViewCell {
    
    
       @IBOutlet var txtFldCardNo: UITextField!
       @IBOutlet weak var txtFldNationalId: UITextField!
       @IBOutlet weak var txtFldPostCode: UITextField!
       @IBOutlet var btnState: UIButton!
       @IBOutlet var txtFldMobile: UITextField!
       
     
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           
           // Configure the view for the selected state
       }
    
}

