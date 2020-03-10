//
//  MoyaUltis.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//



import Foundation
import SwiftyJSON
import Moya
import Result

struct MoyaUltis {
    static func checkRequest(response: Response, success: (JSON) -> Void, hasError: (String) -> Void) {
        do {
            let json = try JSON.init(data: response.data)
            let error = json["error"].boolValue
            if error {
                if json["status_message"].stringValue == "Invalid API key: You must be granted a valid key." {
                    return
                }
                hasError(json["message"].stringValue)
            } else {
                success(json)
            }
        } catch(let error) {
            hasError(error.localizedDescription)
        }
    }
}

