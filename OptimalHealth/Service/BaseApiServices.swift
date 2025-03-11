//
//  BaseApiServices.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import Foundation
import Alamofire

class BaseApiServices{
//    func createHeader()->HTTPHeaders{
//        let headers:HTTPHeaders = [
//            .contentType("application/x-www-form-urlencoded")
//        ]
//        return headers
//    }
//
//    func createJsonHeader()->HTTPHeaders{
//        let headers:HTTPHeaders = [
//            .contentType("application/json")
//        ]
//        return headers
//    }
    
    func createTokenHeader()->HTTPHeaders{
        let token = AppConstant.retrievFromDefaults(key: StringConstant.authorization)
        let headers:HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/x-www-form-urlencoded"
        ]
        return headers
    }
    
    func createJsonTokenHeader()->HTTPHeaders{
        let token = AppConstant.retrievFromDefaults(key: StringConstant.authorization)
        let headers:HTTPHeaders = [
            "Authorization": token,
            "Accept": "application/json"
        ]
        return headers
    }
}
