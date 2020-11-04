//
//  Phone.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 02/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import Foundation
import ObjectMapper

class Phone : Mappable {
    var work: String?
    var home: String?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        work <- map[CAP_DATA_WORK]
        home <- map[CAP_DATA_HOME]
    }
}
