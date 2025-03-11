//
//  SearchListsTableViewCell.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/11/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class SearchListsTableViewCell: UITableViewCell {
    
    @IBOutlet var providerName: UILabel!
    @IBOutlet var addressName: UILabel!
    @IBOutlet var stateName: UILabel!
    @IBOutlet var cityName: UILabel!
    @IBOutlet var searchImageView: UIImageView!
    @IBOutlet var lblDistance: UILabel!
    
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    @IBOutlet weak var btnRating: UIButton!
    
//    @IBOutlet var lblLikeCount: UILabel!
//    @IBOutlet var lblDisappointCount: UILabel!
//    @IBOutlet var btnLike: UIButton!
//    @IBOutlet var btnDisappoint: UIButton!
//    @IBOutlet var imgViewLike: UIImageView!
//    @IBOutlet var imgViewDisappoint: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        stateName.layer.borderWidth = 1
//        stateName.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.40).cgColor
        stateName.layer.cornerRadius = 3
        stateName.clipsToBounds = true
        
//        cityName.layer.borderWidth = 1
//        cityName.layer.borderColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.40).cgColor
        cityName.layer.cornerRadius = 3
        cityName.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

