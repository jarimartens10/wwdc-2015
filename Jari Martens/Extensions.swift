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