//
//  Asteroid.swift
//  Asterank
//
//  Created by Sascha Müllner on 25.01.16.
//  Copyright © 2016 Sascha Muellner. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Asteroid: Mappable {
    var id :String!
    var fullName :String!
    var asteroidClass :String!
    var asteroidType :String!
    var price :Double!
    var profit :Double!
    var closeness :Double!
    let transformToDouble = TransformOf<Double, AnyObject>(fromJSON: { (value: AnyObject?) -> Double? in
        if value != nil {
            switch value {
            case let aDouble as Double:
                return aDouble
            case let aString as String:
                return Double(aString)
            default: break
            }
        }
        return 0.0
        }, toJSON: { (value: Double?) -> AnyObject? in
            if let value = value {
                return String(value)
            }
            return nil
    })
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["full_name"]
        asteroidClass <- map["class"]
        asteroidType <- map["pha"]
        price <- (map["price"], self.transformToDouble)
        profit <- (map["profit"], self.transformToDouble)
        closeness <- (map["closeness"], self.transformToDouble)
    }
}