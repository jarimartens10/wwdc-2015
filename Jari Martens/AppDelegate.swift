//
//  AppDelegate.swift
//  Jari Martens
//
//  Created by Jari Martens on 14-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let auth = SPTAuth.defaultInstance()
        auth.clientID = Constants.ClientID
        auth.requestedScopes = [SPTAuthStreamingScope]
        auth.redirectURL = NSURL(string: Constants.RedirectURI)
        auth.sessionUserDefaultsKey = Constants.UserDefaultsKey
        return true
    }
}

struct Constants {
    static let ClientID = "826dd9f50b494b41ba2cf0b239c22594"
    static let UserDefaultsKey = "sessionSpotify"
    static let RedirectURI = "jarimartens://spotifyCallback"
}