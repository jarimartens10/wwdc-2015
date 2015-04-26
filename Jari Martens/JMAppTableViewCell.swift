//
//  JMAppTableViewCell.swift
//  Jari Martens
//
//  Created by Jari Martens on 16-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMAppTableViewCell: JMTableViewCell {
    private lazy var AppImageView: JMImageView = {
        var imageView = JMImageView(frame: CGRect(x: 25.0, y: 25.0, width: 100, height: 100))
        imageView.backgroundColor = UIColor.clearColor()
        imageView.layer.cornerRadius = 25.0
        imageView.layer.masksToBounds = true
        imageView.delegate = self.delegate
        return imageView
    }()
    private lazy var AppTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0.0, y: 115, width: 150, height: 50))
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        label.userInteractionEnabled = false
        return label
    }()
    private lazy var AppDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 150.0, y: 20.0, width: self.frame.width-160.0, height: self.frame.height-55.0)
        textView.text = self.representingApp?.description
        textView.backgroundColor = UIColor.clearColor()
        textView.textColor = UIColor.whiteColor()
        textView.editable = false
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textView.userInteractionEnabled = true
        return textView
    }()
    private lazy var AppAvailabilityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 50)
        label.center = CGPoint(x: self.center.x, y: self.frame.height-25.0)
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        label.textAlignment = NSTextAlignment.Center
        label.userInteractionEnabled = false
        return label
    }()
    var delegate: JMImageViewDelegate? {
        didSet{
            AppImageView.delegate = delegate
        }
    }
    
    var representingApp: JMApps! {
        didSet{
            AppImageView.image = self.representingApp.image
            AppTitleLabel.text = representingApp.appName
            AppDescriptionTextView.text = representingApp.description
            AppAvailabilityLabel.text = representingApp.available ? "Available in the App Store" : "Coming soon to iOS"
            AppAvailabilityLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 50)
            AppAvailabilityLabel.center = CGPoint(x: self.center.x, y: self.frame.height-25.0)
            AppDescriptionTextView.frame = CGRect(x: 150.0, y: 20.0, width: self.frame.width-160.0, height: self.frame.height-75.0)
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
