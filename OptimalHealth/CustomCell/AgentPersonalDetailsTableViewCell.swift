//
//  AgentPersonalDetailsTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class AgentPersonalDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtFldAgentId: UITextField!
    @IBOutlet var txtFldPostCode: UITextField!
    @IBOutlet var txtFldNationalId: UITextField!
    @IBOutlet var txtFldMobile: UITextField!
    @IBOutlet var BtnState: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

