//
//  JMClassDescriptionViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 17-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//


import UIKit

final class JMClassDescriptionViewController: UIViewController
{
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue }
    }
}