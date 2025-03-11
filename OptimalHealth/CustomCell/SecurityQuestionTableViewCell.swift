//
//  SecurityQuestionTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 15/04/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class SecurityQuestionTableViewCell: UITableViewCell {

    @IBOutlet var lblQuestion1: UILabel!
    @IBOutlet var lblQuestion2: UILabel!
    @IBOutlet var lblQuestion3: UILabel!
    @IBOutlet var btnQuestion1: UIButton!
    @IBOutlet var btnQuestion2: UIButton!
    @IBOutlet var btnQuestion3: UIButton!
    @IBOutlet var txtFldAnswer1: UITextField!
    @IBOutlet var txtFldAnswer2: UITextField!
    @IBOutlet var txtFldAnswer3: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        setplaceHolderColor(txtFld: txtFldAnswer1, placeholder: "Insert Question1 Answer")
        setplaceHolderColor(txtFld: txtFldAnswer2, placeholder: "Insert Question2 Answer")
        setplaceHolderColor(txtFld: txtFldAnswer3, placeholder: "Insert Question3 Answer")
    }
    
    func setplaceHolderColor(txtFld: UITextField, placeholder: String){
        txtFld.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
