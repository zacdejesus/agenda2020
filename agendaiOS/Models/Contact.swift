//
//  Contact.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 02/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import Foundation
import ObjectMapper

class Contact: Mappable {
    var name: String?
    var id: String?
    var companyName: String?
    var isFavorite: Bool?
    var smallImageURL: String?
    var largeImageURL: String?
    var emailAddress: String?
    var birthdate: String?
    var phone: Phone?
    var address: Address?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        name <- map[CAP_DATA_NAME]
        id <- map[CAP_DATA_ID]
        companyName <- map[CAP_DATA_COMPANYNAME]
        isFavorite <- map[CAP_DATA_ISFAVORITE]
        smallImageURL <- map[CAP_DATA_SMALLIMAGEURL]
        largeImageURL <- map[CAP_DATA_LARGEIMAGEURL]
        emailAddress <- map[CAP_DATA_EMAILADDRESS]
        birthdate <- map[CAP_DATA_BIRTHDATE]
        phone <- map[CAP_DATA_PHONE]
        address <- map[CAP_DATA_ADDRESS]
    }
}
