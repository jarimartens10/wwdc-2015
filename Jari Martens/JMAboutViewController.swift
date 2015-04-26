//
//  ViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 14-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit
import MessageUI

final class JMAboutViewController: JMViewController, UITextViewDelegate {
    //MARK: - IBOutlets
    //###########################################################

    @IBOutlet weak var ProfileImageView: JMImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var swipeGestureRecognizerDown: UISwipeGestureRecognizer!
    @IBOutlet var swipeGestureRecognizerUp: UISwipeGestureRecognizer!
    
    //###########################################################
    
    
    //MARK: - Lazy Variables 😴
    //###########################################################
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: -self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width, height: 50))
        label.center = CGPoint(x: -self.view.frame.width, y: self.view.frame.height*0.25+150)
        label.text = "Jari Martens"
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        return label
        
    }()
    
    private lazy var textView: UITextView = {
        let tempTextView = UITextView(frame: CGRect(x: 0.0, y: self.view.frame.height*0.25+200, width: self.view.frame.width*0.9, height: self.view.frame.height-self.view.frame.height*0.25-20))
        tempTextView.center = CGPoint(x: self.view.center.x, y: tempTextView.center.y)
        let text = "My name is Jari Martens, I am 15 years old and I am from the Netherlands. I am currently ‘studying’ at the Varendonck-College, which is situated in the small town of Asten, which is also where I live. In the Netherlands, we differentiate in schools. This means that there are different levels of high school possible. I am following VWO, which is the highest level of education possible in high school. For my curriculum, see the tab Classes.\n\nI have 2 little brothers, called Stijn and Rick, respectively 13 and 10 years old. My father is called Pierre and my mother's name is Saskia. They are both 49 years old.\n\nMy hobbies are, besides programming, playing soccer, playing chess and skiing. I have learned to ski when I was ~ 5 years old. Since the last 6 years or so, we go to the beautiful town of Flachau in the Christmas holidays. \n\nI started learning how to program iOS apps in March 2014, with very little understanding about Object Oriented Programming. I followed all classes of Paul Hegarty about iOS 7 apps via iTunes U, to understand more about the language Objective C. I have recently published my first app to the iOS App Store, called ConnectR, which is written completely in Swift, except for third-party open source libraries. ConnectR is a social networking app that works as a social hub, so it can i.e. display the data of various social networks in one timeline.\n\nI hope you will like love this app,\n\nYours Sincerely, Jari Martens"
        let nsText = text as NSString
        let textRange = NSMakeRange(0, nsText.length)
        let attributedString = NSMutableAttributedString(string: nsText as String)
        
        nsText.enumerateSubstringsInRange(textRange, options: NSStringEnumerationOptions.ByWords) { (substring, substringRange, enclosingRange, stop) in
            
            if (substring == "like") {
                attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(integer: 1), range: substringRange)
            }
        }
        
        var textAttachment = NSTextAttachment()
        var img = UIImage(named: "photo_skiing")
        let oldWidth = img!.size.width
        //Subtracting 10 for padding
        //Multiplying by scale to compensate for @3x and @2x
        let scaleFactor = oldWidth/(tempTextView.frame.width-10)*img!.scale
        println("\(scaleFactor)")
        let image: CIImage = CIImage(image: img!)!
        textAttachment.image = UIImage(CIImage: image, scale: scaleFactor, orientation: UIImageOrientation.Up)
        
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.replaceCharactersInRange(NSMakeRange(837, 1), withAttributedString: attrStringWithImage)
        tempTextView.attributedText = attributedString
        tempTextView.textColor = UIColor.whiteColor()
        tempTextView.backgroundColor = UIColor.clearColor()
        tempTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        tempTextView.hidden = true
        tempTextView.scrollEnabled = true
        tempTextView.editable = false
        tempTextView.delegate = self
        return tempTextView
    }()
    
    private lazy var swipeUpImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Swipe_Up"))
        imageView.frame = CGRect(x: 0.0, y: self.view.frame.height*0.25+200, width: self.view.frame.width, height: self.view.frame.height*0.75-200-(self.tabBarController?.tabBar.frame.height ?? 0))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        return imageView
    }()

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
        ProfileImageView.image = UIImage(named: "photo_me")
        ProfileImageView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height*1.5)
        ProfileImageView.frame = CGRect(x: scrollView.center.x-201, y: view.frame.height*0.50-200, width: 200, height: 200)
        ProfileImageView.center = CGPoint(x: view.center.x, y: view.frame.height*0.25)
        scrollView.addSubview(swipeUpImageView)
        scrollView.addSubview(textView)
        scrollView.addSubview(nameLabel)
        scrollView.scrollEnabled = false
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
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
                    self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
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
                    self.nameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
                    self.textView.hidden = false
                    self.swipeUpImageView.hidden = true
                },
                completion: nil)
        }
    }
    
    //###########################################################
    
    
    //MARK: - Notifications
    //###########################################################
    
    func preferredContentSizeChanged(notification: NSNotification) {
        textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    //###########################################################
    
    
    //MARK: - UITextViewDelegate
    //###########################################################
    
    func textView(textView: UITextView, shouldInteractWithTextAttachment textAttachment: NSTextAttachment, inRange characterRange: NSRange) -> Bool {
        let imageInfo = JTSImageInfo()
        imageInfo.image = textAttachment.image
        let imageViewer = JTSImageViewController(
            imageInfo: imageInfo,
            mode: JTSImageViewControllerMode.Image,
            backgroundStyle: JTSImageViewControllerBackgroundOptions.Blurred)
        imageViewer.interactionsDelegate = self
        imageViewer.showFromViewController(self, transition: JTSImageViewControllerTransition._FromOriginalPosition)
        
        return false
    }
    
    //###########################################################
}