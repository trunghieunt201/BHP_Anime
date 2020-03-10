//
//  SettingEnum.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/9/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation

enum SettingEnum {
    case rateApp
    case feedBack
    case shareThisApp
    case upgrade
    case about
    
    var title :String{
        switch self {
        case .rateApp:
            return "Rate app"
        case .feedBack:
            return "Feedback"
        case .shareThisApp:
            return "Share this app"
        case .upgrade:
            return "Upgrade to Premium"
        case .about:
            return "About"
        }
    }
    
    var img : String{
        switch self {
        case .rateApp:
            return "star"
        case .feedBack:
            return "mail"
        case .shareThisApp:
            return "ic_share"
        case .upgrade:
            return "ic_upgrade"
        case .about:
            return "ic_info"

        }
    }
    
    
}

