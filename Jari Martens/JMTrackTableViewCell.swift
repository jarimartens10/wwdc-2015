//
//  JMTrackTableViewCell.swift
//  Jari Martens
//
//  Created by Jari Martens on 23-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

class JMTrackTableViewCell: JMTableViewCell {
    
    var representingTrack: SPTTrack! {
        didSet{
            detailTextLabel?.text = NSTimeInterval.stringForTimeInterval(representingTrack.duration)
            detailTextLabel?.textColor = UIColor.whiteColor()
            textLabel?.text = representingTrack.name
            textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        super.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailTextLabel?.frame = CGRect(x: frame.size.width - 50, y: detailTextLabel?.frame.origin.y ?? 0, width: 45, height: detailTextLabel?.frame.height ?? 0)
        
        textLabel?.frame.size.width = (detailTextLabel?.frame.origin.x ?? 0) - (textLabel?.frame.origin.x ?? 0)
        textLabel?.adjustsFontSizeToFitWidth = true
    }
    
}
