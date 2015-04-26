//
//  JMNoAnimationSegue.swift
//  Jari Martens
//
//  Created by Jari Martens on 26-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

class JMNoAnimationSegue: UIStoryboardSegue {
    override func perform() {
        let source = sourceViewController as! UIViewController
        if let navigation = source.navigationController {
            navigation.pushViewController(destinationViewController as! UIViewController, animated: false)
        }
    }
}
