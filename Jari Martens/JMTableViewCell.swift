//
//  JMTableViewCell.swift
//  Jari Martens
//
//  Created by Jari Martens on 16-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

class JMTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //Initialization code
        tintColor = UIColor.whiteColor()
    }

}
