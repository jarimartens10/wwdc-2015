//
//  JMTableView.swift
//  Jari Martens
//
//  Created by Jari Martens on 15-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

class JMTableView: UITableView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = UIColor.clearColor()
    }
    
}