//
//  LoginDetailsTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class LoginDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldDisplayName: UITextField!
    @IBOutlet var txtFldPassword: UITextField!
    @IBOutlet var txtFldCnfPassword: UITextField!
    @IBOutlet var btnPasswordTogle: UIButton!
    @IBOutlet var btnCnfPasswordTogle: UIButton!
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setplaceHolderColor(txtFld: txtFldEmail, placeholder: "Insert Mobile Number eg. 0112345678")
        setplaceHolderColor(txtFld: txtFldDisplayName, placeholder: "Insert your display name")
        setplaceHolderColor(txtFld: txtFldPassword, placeholder: "Insert Your Password")
        setplaceHolderColor(txtFld: txtFldCnfPassword, placeholder: "Retype Password")
    }
    
    func setplaceHolderColor(txtFld: UITextField, placeholder: String){
        txtFld.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

