//
//  MenuModel.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 13/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import SwiftyJSON

class MenuModel {
    
    enum Key:String{
        case objid = "Objid"
        case objType = "ObjType"
        case url = "Url"
        case fdesc = "Fdesc"
        case image = "Image"
        case ordSeq = "OrdSeq"
        case subMenu = "SubMenu"
    }
    
    var objid :String?
    var objType:String?
    var url:String?
    var fdesc:String?
    var image:String?
    var ordSeq:String?
    var subMenu:[MenuModel]?
    
    public static func parseJSON(json:JSON)->MenuModel{
        let model = MenuModel()
        model.objid = json[Key.objid.rawValue].stringValue
        model.objType = json[Key.objType.rawValue].stringValue
        model.url = json[Key.url.rawValue].stringValue
        model.fdesc = json[Key.fdesc.rawValue].stringValue.uppercased()
        model.image = json[Key.image.rawValue].stringValue
        model.ordSeq = json[Key.ordSeq.rawValue].stringValue
        return model
    }
    
    public static func parseJSONSubMenu(json:JSON)->MenuModel{
        let model = MenuModel()
        model.objid = json[Key.objid.rawValue].stringValue
        model.objType = json[Key.objType.rawValue].stringValue
        model.url = json[Key.url.rawValue].stringValue
        model.fdesc = json[Key.fdesc.rawValue].stringValue
        model.image = json[Key.image.rawValue].stringValue
        model.ordSeq = json[Key.ordSeq.rawValue].stringValue
        return model
    }
}
