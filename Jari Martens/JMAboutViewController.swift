//
//  ViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 14-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit
import MessageUI

final class JMAboutViewController: JMViewController {
    //MARK: - Variables
    //###########################################################

    @IBOutlet weak var ProfileImageView: JMImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var swipeGestureRecognizerDown: UISwipeGestureRecognizer!
    @IBOutlet var swipeGestureRecognizerUp: UISwipeGestureRecognizer!
    private var nameLabel = UILabel()
    private var textView = UITextView()

    //###########################################################


    //MARK: - Overriding Functions
    //###########################################################

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ProfileImageView.layer.cornerRadius = 100
        ProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        ProfileImageView.layer.borderWidth = 5.0
        ProfileImageView.layer.masksToBounds = true
        ProfileImageView.image = UIImage(named: "backgroundImage")
        ProfileImageView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height*1.5)
        ProfileImageView.frame = CGRect(x: scrollView.center.x-201, y: view.frame.height*0.50-200, width: 200, height: 200)
        ProfileImageView.center = CGPoint(x: view.center.x, y: view.frame.height*0.25)
        nameLabel = UILabel(frame: CGRect(x: -view.frame.width, y: view.frame.height, width: view.frame.width, height: 50))
        nameLabel.center = CGPoint(x: -view.frame.width, y: view.frame.height*0.25+150)
        nameLabel.text = "Jari Martens"
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont.systemFontOfSize(16.0)
        
        textView = UITextView(frame: CGRect(x: 0.0, y: view.frame.height*0.25+200, width: view.frame.width*0.9, height: view.frame.height))
        textView.center = CGPoint(x: view.center.x, y: textView.center.y)
        textView.text = "My name is Jari Martens and I started learning for iOS apps in March 2014."
        textView.textColor = UIColor.whiteColor()
        textView.backgroundColor = UIColor.clearColor()
        textView.hidden = true
        textView.editable = false
        scrollView.addSubview(textView)
        scrollView.addSubview(nameLabel)
        scrollView.scrollEnabled = false
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1.5,
            delay: 0.5,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 3.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () -> Void in
                self.nameLabel.center = CGPoint(x: self.view.center.x, y: self.view.frame.height*0.25+150)
            },
            completion: nil)
    }
    
    //###########################################################

    
    //MARK: - Swipe Recognizer
    //###########################################################
    
    @IBAction func didSwipe(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == UISwipeGestureRecognizerDirection.Down {
            // Swipe down, page going up
            UIView.animateWithDuration(1.0,
                delay: 0.0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 5.0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: { () -> Void in
                    self.scrollView.scrollRectToVisible(CGRect(x: 0.0, y: 0.0, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: false)
                    self.nameLabel.font = UIFont.systemFontOfSize(16.0)
                },
                completion: nil)
        }
        else if swipe.direction == UISwipeGestureRecognizerDirection.Up {
            // Swipe up, page going down
            UIView.animateWithDuration(1.0,
                delay: 0.0,
                usingSpringWithDamping: 0.85,
                initialSpringVelocity: 5.0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: { () -> Void in
                    self.scrollView.scrollRectToVisible(CGRect(x: 0.0, y: self.scrollView.frame.height*0.25+125, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: false)
                    self.nameLabel.font = UIFont.boldSystemFontOfSize(24.0)
                    self.textView.hidden = false
                },
                completion: nil)
        }
    }
    
    //###########################################################
}