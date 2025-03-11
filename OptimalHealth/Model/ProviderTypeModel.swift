//
//  ProviderTypeModel.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProviderTypeModel {
    
    enum Key:String{
        case refCd = "Refcd"
        case fDesc = "Fdesc"
    }
    
    var refCd:String?
    var fDesc:String?
    var image:String?
    
    public static func parseJSON(json:JSON)->ProviderTypeModel{
        let model = ProviderTypeModel()
        model.refCd = json[Key.refCd.rawValue].stringValue
        model.fDesc = json[Key.fDesc.rawValue].stringValue
        return model
    }
    
    func add(refCd:String,fDesc:String) {
        self.refCd = refCd
        self.fDesc = fDesc
    }
}
