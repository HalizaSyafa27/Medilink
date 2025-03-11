//
//  NonMedilinkMemberTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class NonMedilinkMemberTableViewCell: UITableViewCell {
    
    
    @IBOutlet var txtFldName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtFldNationalId: UITextField!
    @IBOutlet var txtFldMobile: UITextField!
    @IBOutlet var txtFldDOB: UITextField!
   
    @IBOutlet var btnGender: UIButton!
    @IBOutlet var txtFldCity: UITextField!
    @IBOutlet var txtFldAddress: UITextField!
    @IBOutlet var btnState: UIButton!
    @IBOutlet var btnMale: UIButton!
    @IBOutlet var btnFemale: UIButton!
    @IBOutlet var imgViewMale: UIImageView!
    @IBOutlet var imgViewFemale: UIImageView!
    @IBOutlet var btnDOB: UIButton!
    @IBOutlet weak var btnChooseIdType: UIButton!
    @IBOutlet weak var lblIDType: UILabel!
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
           
           setplaceHolderColor(txtFld: txtFldName, placeholder: "Insert Your Name")
           setplaceHolderColor(txtFld: txtEmail, placeholder: "Insert E-Mail Address")
           setplaceHolderColor(txtFld: txtFldNationalId, placeholder: "Insert NIK/Card No")
           setplaceHolderColor(txtFld: txtFldMobile, placeholder: "Insert Mobile Number")
           setplaceHolderColor(txtFld: txtFldDOB, placeholder: "Insert Date of Birth")
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
