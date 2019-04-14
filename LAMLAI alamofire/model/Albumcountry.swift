//
//  Abumcountry.swift
//  LAMLAI alamofire
//
//  Created by Mac on 1/19/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation
import Alamofire
class Country {
    var namecountry:String?
    var namedemonym:String?
    var flag:String?
    var numericCode:String?
    var region:String?
    var nativeName:String?
    var cioc:String?
    var alpha2Code:String?

    
    init(Json: [String: Any]){
        if let namecountry = Json["name"] as? String {
            self.namecountry = namecountry
            
        }
        if let namedemonym = Json["demonym"] as? String {
            self.namedemonym = namedemonym
        }
        if let alpha2Code = Json["alpha2Code"] as? String{
            self.alpha2Code = alpha2Code
        }
        if let flag = Json["flag"] as?String {
            self.flag = flag
        }
    
        
        if let numericCode = Json["numericCode"] as? String {
            self.numericCode = numericCode
            
        }
        if let region = Json["region"] as? String {
            self.region = region
        }
        if let nativeName = Json["nativeName"] as? String {
            self.nativeName = nativeName
        }
        if let cioc = Json["cioc"] as? String {
            self.cioc = cioc
        }
        
    }
    
    
    
}
