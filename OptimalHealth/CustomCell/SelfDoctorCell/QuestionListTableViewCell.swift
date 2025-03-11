//
//  QuestionListTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 30/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
