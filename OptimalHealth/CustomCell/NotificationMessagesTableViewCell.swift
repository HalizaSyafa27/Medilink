//
//  NotificationMessagesTableViewCell.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 9/5/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class NotificationMessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnDelete: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initDesign()
    }
    
    func initDesign(){
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.borderColor = UIColor.gray.cgColor
        //viewContainer.layer.borderWidth = 1.0
        
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.masksToBounds = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add Shadow Effect on Virtual card
        
//        let shadow = UIBezierPath(roundedRect: viewContainer.bounds, cornerRadius: 10.0).cgPath
//        viewContainer.layer.shadowRadius = 10
//        viewContainer.layer.shadowColor = UIColor.black.cgColor
//        viewContainer.layer.shadowOpacity = 0.5
//        viewContainer.layer.masksToBounds = false
//        viewContainer.layer.shadowPath = shadow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
