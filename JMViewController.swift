//
//  JMViewController.swift
//  
//
//  Created by Jari Martens on 14-04-15.
//
//

import UIKit
import MessageUI

class JMViewController: UIViewController, JMImageViewDelegate, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //MARK: - JMImageViewDelegate
    func didTapImageView(imageView: JMImageView) {
        let imageInfo = JTSImageInfo()
        imageInfo.image = imageView.image
        imageInfo.referenceRect = imageView.frame
        imageInfo.referenceView = imageView.superview
        imageInfo.referenceContentMode = imageView.contentMode
        imageInfo.referenceCornerRadius = imageView.layer.cornerRadius
        let imageViewer = JTSImageViewController(
            imageInfo: imageInfo,
            mode: JTSImageViewControllerMode.Image,
            backgroundStyle: JTSImageViewControllerBackgroundOptions.Blurred)
        imageViewer.interactionsDelegate = self
        imageViewer.showFromViewController(self, transition: JTSImageViewControllerTransition._FromOriginalPosition)
    }
    
    func imageViewerAllowCopyToPasteboard(imageViewer: JTSImageViewController!) -> Bool {
        return true
    }
    
    func imageViewerDidLongPress(imageViewer: JTSImageViewController!, atRect rect: CGRect) {
        let controller = UIAlertController(title: "Share", message: "Share this image", preferredStyle: UIAlertControllerStyle.ActionSheet)
        controller.addAction(UIAlertAction(title: "Mail", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            if MFMailComposeViewController.canSendMail() {
                let composer = MFMailComposeViewController(nibName: nil, bundle: nil)
                composer.mailComposeDelegate = nil//self
                composer.addAttachmentData(UIImageJPEGRepresentation(imageViewer.image, 0.9), mimeType: "image/jpeg", fileName: "image.jpg")
                composer.setSubject("Image")
                
                composer.mailComposeDelegate = self
                imageViewer.presentViewController(composer, animated: true, completion: nil)
            }
            else {
                let alert = UIAlertController(
                    title: "Cannot send email",
                    message: "This device cannot send an email, check your email settings in Preferences",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil))
                
                imageViewer.presentViewController(alert,
                    animated: true,
                    completion: nil)
            }
        }))
        
        controller.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            UIImageWriteToSavedPhotosAlbum(imageViewer.image, nil, nil, nil)
        }))
        
        controller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        imageViewer.presentViewController(controller, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        //If not hidden, display status bar in white text
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
