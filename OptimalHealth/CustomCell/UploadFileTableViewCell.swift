//
//  UploadFileTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 18/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class UploadFileTableViewCell: UITableViewCell {

    @IBOutlet var lblFileName: UILabel!
    @IBOutlet var lblFileSize: UILabel!
    @IBOutlet var btnRemove: UIButton!
    @IBOutlet var imgViewAttachment: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
