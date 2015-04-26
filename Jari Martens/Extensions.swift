//
//  extensions.swift
//  Jari Martens
//
//  Created by Jari Martens on 18-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

extension UITabBarItem {
    func setSelectedImageName(name: String){
        self.selectedImage = UIImage(named: name)
    }
}

extension NSTimeInterval {
    var seconds: Double {
        return trunc(self - minutes * 60)
    }
    
    var minutes: Double {
        return floor(self/60)
    }
    
    static func stringForTimeInterval(timeInterval: NSTimeInterval) -> String {
        let secondsToShow = Int(timeInterval.seconds) < 10 ? "0\(Int(timeInterval.seconds))" : "\(Int(timeInterval.seconds))"
        return "\(Int(timeInterval.minutes)):\(secondsToShow)"
    }
}