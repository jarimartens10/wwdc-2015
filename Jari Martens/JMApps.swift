//
//  JMApps.swift
//  Jari Martens
//
//  Created by Jari Martens on 15-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import Foundation

enum JMApps {
    case ConnectR
    case HVAC_Plus
    
    static var all_values: Array<JMApps> {
        return [.ConnectR, .HVAC_Plus]
    }
    
    var available: Bool {
        switch self {
        case .ConnectR: return true
        case .HVAC_Plus: return false
        }
    }
    
    var description: String {
        switch self {
        case .ConnectR: return "ConnectR is"
        case .HVAC_Plus: return "HVAC Plus is"
        }
    }
    
    var appName: String {
        switch self {
        case .ConnectR: return "ConnectR"
        case .HVAC_Plus: return "HVAC Plus"
        }
    }
    
    var link: NSURL? {
        switch self {
        case .ConnectR: return NSURL(string: "https://itunes.apple.com/us/app/id905696962")
        default: return nil
        }
    }
    
    var image: UIImage? {
        switch self {
        case .ConnectR: return UIImage(named: "connectr_app_icon")
        case .HVAC_Plus: return UIImage(named: "hvac_app_icon")
        }
    }
}