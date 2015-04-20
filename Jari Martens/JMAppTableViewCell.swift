//
//  JMAppTableViewCell.swift
//  Jari Martens
//
//  Created by Jari Martens on 16-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMAppTableViewCell: JMTableViewCell {
    var AppImageView = JMImageView(frame: CGRect(x: 25.0, y: 25.0, width: 100, height: 100))
    var AppTitleLabel = UILabel(frame: CGRect(x: 0.0, y: 115, width: 150, height: 50))
    var AppDescriptionTextView = UITextView()
    var AppAvailabilityLabel = UILabel()
    var delegate: JMImageViewDelegate?
    
    var representingApp: JMApps! {
        didSet{
            AppImageView.image = representingApp.image
            AppImageView.backgroundColor = UIColor.clearColor()
            AppImageView.layer.cornerRadius = 25.0
            AppImageView.layer.masksToBounds = true
            AppImageView.delegate = delegate
            AppTitleLabel.text = representingApp.appName
            AppTitleLabel.textColor = UIColor.whiteColor()
            AppTitleLabel.textAlignment = NSTextAlignment.Center
            AppTitleLabel.font = UIFont.systemFontOfSize(24.0)
            AppTitleLabel.userInteractionEnabled = false
            AppDescriptionTextView.frame = CGRect(x: 150.0, y: 20.0, width: self.frame.width-90.0, height: self.frame.height-40.0)
            AppDescriptionTextView.text = representingApp.description
            AppDescriptionTextView.backgroundColor = UIColor.clearColor()
            AppDescriptionTextView.textColor = UIColor.whiteColor()
            AppDescriptionTextView.editable = false
            AppDescriptionTextView.font = UIFont.systemFontOfSize(14.0)
            AppDescriptionTextView.userInteractionEnabled = false
            AppAvailabilityLabel.text = representingApp.available ? "Available in the App Store" : "Coming soon to iOS"
            AppAvailabilityLabel.textColor = UIColor.whiteColor()
            AppAvailabilityLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 50)
            AppAvailabilityLabel.center = CGPoint(x: self.center.x, y: self.frame.height-50.0)
            AppAvailabilityLabel.font = UIFont.systemFontOfSize(14.0)
            AppAvailabilityLabel.textAlignment = NSTextAlignment.Center
            AppAvailabilityLabel.userInteractionEnabled = false
        }
    }
    
    override func setup(){
        super.setup()
        contentView.addSubview(AppImageView)
        contentView.addSubview(AppTitleLabel)
        contentView.addSubview(AppDescriptionTextView)
        contentView.addSubview(AppAvailabilityLabel)
    }

}
