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
        case .ConnectR: return "ConnectR is a social media application that lets users combine multiple social networks. This means users can post messages to multiple social networks. Users can also view the timelines of multiple social networks as one timeline. They can also search for users and hashtags on multiple social networks. Currently, Twitter and Instagram are supported. The app is published on name of my father’s company, but as you can see at the copyright notice at the iOS App Store, it is developed by me."
        case .HVAC_Plus: return "HVAC Plus is an app I am currently developing for my father, who is a consultant to contractors for the installations in a building. With the app, you can perform calculations that are common in his field of expertise. Those calculations rely on multiple variables, that are automatically saved and loaded into each calculation. An example of this is calculating the needed size of the ducts, based on a given air volume and the speed of the air inside the duct."
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