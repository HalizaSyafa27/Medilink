//
//  ProductModel.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 27/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProductModel {
    
    enum Key:String{
        
        case name = "Name"
        case rating = "Rating"
        case star = "Star"
        case ratingCnt = "RatingCnt"
        case ratingID = "RatingID"
        case userID = "UserID"
        case providerName = "ProviderName"
        case ratingRemarks = "RatingRemarks"
        case publishDt = "PublishDt"
        case providerCode = "providercode"
        case fileData = "FileData"
        case fileName = "FileName"
    }
    var name:String?
    var rating:Decimal?
    var star:Decimal?
    var ratingCnt:Decimal?
    var ratingID:String?
    var userID:String?
    var providerName:String?
    var ratingRemarks:String?
    var publishDt:String?
    var providerCode:String?
    var sumRating:String?
    var sumStar:String?
    var sumRatingCnt:String?
    var fileData:String?
    var fileName:String?
    
    public static func parseJSON(json:JSON)->ProductModel{
        let model = ProductModel()
        model.name = json[Key.name.rawValue].stringValue
        model.rating = Decimal(json[Key.rating.rawValue].intValue)
        model.star = Decimal(json[Key.star.rawValue].intValue)
        model.ratingCnt = Decimal(json[Key.ratingCnt.rawValue].intValue)
        model.ratingID = json[Key.ratingID.rawValue].stringValue
        model.userID = json[Key.userID.rawValue].stringValue
        model.providerName = json[Key.providerName.rawValue].stringValue
        model.ratingRemarks = json[Key.ratingRemarks.rawValue].stringValue
        model.publishDt = json[Key.publishDt.rawValue].stringValue
        model.providerCode = json[Key.providerCode.rawValue].stringValue
        model.fileData = json[Key.fileData.rawValue].stringValue
        model.fileName = json[Key.fileName.rawValue].stringValue
        return model
    }
}
