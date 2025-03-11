//
//  ViewHistoryListTableViewCell.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 29/02/2024.
//  Copyright © 2024 Oditek. All rights reserved.
//

import UIKit

class ViewHistoryListTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBMI: UILabel!
    @IBOutlet weak var lblBodyFat: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.clipsToBounds = true
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 8
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.white.cgColor
        self.setViewSettingWithBgShade(view: mainView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setViewSettingWithBgShade(view: UIView)
    {
        //MARK:- Shade a view
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
    }

}
