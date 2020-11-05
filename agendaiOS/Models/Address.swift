//
//  Address.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 03/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import Foundation
import ObjectMapper

class Address: Mappable {
    var street: String?
    var city: String?
    var state: String?
    var country: String?
    var zipCode: String?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        street <- map[CAP_DATA_STREET]
        city <- map[CAP_DATA_CITY]
        state <- map[CAP_DATA_STATE]
        country <- map[CAP_DATA_COUNTRY]
        zipCode <- map[CAP_DATA_ZIPCODE]
    }
}
