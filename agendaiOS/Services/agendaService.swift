//
//  agendaService.swift
//  agendaiOS
//
//  Created by Alejandro de jesus on 02/11/2020.
//  Copyright © 2020 Alejandro de jesus. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class agendaService {
    func getContacts(success: @escaping ([Contact]) -> Void, error errorHandler: @escaping () -> Void) {
        let request = Alamofire.request(API_URL, encoding: URLEncoding.default)
        request.responseArray { ( response: DataResponse<[Contact]> ) in
                if let contacts = response.result.value {
                success(contacts)
            }
        }
    }
}
