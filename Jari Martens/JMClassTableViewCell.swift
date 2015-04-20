//
//  JMTableViewCell.swift
//  Jari Martens
//
//  Created by Jari Martens on 15-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMClassTableViewCell: JMTableViewCell {
    var markLabel = UILabel()
    
    var representingClass: JMClasses! {
        didSet {
            self.detailTextLabel?.text = " \(representingClass.convertedMark)"
            self.detailTextLabel?.textColor = UIColor.whiteColor()
            self.detailTextLabel?.textAlignment = NSTextAlignment.Left
            
            self.markLabel.text = "\(representingClass.mark) |"
            self.markLabel.textColor = UIColor.whiteColor()
            self.markLabel.font = self.detailTextLabel!.font
            self.markLabel.textAlignment = NSTextAlignment.Right
            
            self.textLabel?.text = "\(representingClass.name)"
            self.textLabel?.textColor = UIColor.whiteColor()
            self.textLabel?.numberOfLines = 3
            self.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        }
    }
    
    override func setup(){
        super.setup()
        contentView.addSubview(markLabel)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        detailTextLabel?.frame = CGRect(x: (detailTextLabel?.frame.origin.x ?? 0) + (detailTextLabel?.frame.width ?? 0) - (28), y: detailTextLabel?.frame.origin.y ?? 0, width: 28, height: detailTextLabel?.frame.height ?? 0)
        
        markLabel.frame = CGRect(x: (detailTextLabel?.frame.origin.x ?? 0) - 50, y: detailTextLabel?.frame.origin.y ?? 0, width: 50, height: detailTextLabel?.frame.height ?? 0)
        
        textLabel?.frame.size.width = frame.size.width - markLabel.frame.origin.x
        textLabel?.frame.size.height = frame.size.height
        textLabel?.frame.origin.y = 0
    }

}
