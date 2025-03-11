//
//  NewsTableViewCell.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 06/05/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPublishedOn: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
