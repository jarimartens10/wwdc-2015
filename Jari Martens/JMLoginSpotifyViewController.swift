//
//  JMLoginSpotifyViewController.swift
//  Jari Martens
//
//  Created by Jari Martens on 20-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

final class JMLoginSpotifyViewController: JMViewController, SPTAuthViewDelegate {
    //MARK: - Variables
    //###########################################################

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    private var authViewController: SPTAuthViewController!

    //###########################################################

    
    //MARK: - Overriding Functions
    //###########################################################

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userSessionObj = NSUserDefaults.standardUserDefaults().objectForKey(Constants.UserDefaultsKey) as? NSData {
            let userSession = NSKeyedUnarchiver.unarchiveObjectWithData(userSessionObj) as! SPTSession
            
            if userSession.isValid() {
                loggedIn()
            }
            
        }
    }
    //###########################################################


    //MARK: - Log in functions
    //###########################################################

    private func loggedIn() {
        if SPTAuth.defaultInstance().session.isValid(){
            performSegueWithIdentifier("playMusic", sender: nil)
        }
    }
    
    @IBAction func login(sender: UIButton) {
        openLoginPage()
    }
    
    private func openLoginPage() {
        authViewController = SPTAuthViewController.authenticationViewController()
        authViewController.delegate = self
        authViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        authViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        definesPresentationContext = true
        presentViewController(authViewController, animated: true, completion: nil)
    }
    
    //###########################################################

    
    //MARK: - SPTAuthViewDelegate
    //###########################################################

    func authenticationViewController(authenticationViewController: SPTAuthViewController!, didFailToLogin error: NSError!) {
        // TODO: ADD ALERT
    }
    
    func authenticationViewController(authenticationViewController: SPTAuthViewController!, didLoginWithSession session: SPTSession!) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let userSession = NSKeyedArchiver.archivedDataWithRootObject(session)
        userDefaults.setObject(userSession, forKey: Constants.UserDefaultsKey)
        userDefaults.synchronize()
        
        authenticationViewController.clearCookies(nil)
        
        loggedIn()
    }
    
    func authenticationViewControllerDidCancelLogin(authenticationViewController: SPTAuthViewController!) {
        //Do nothing, just here for conforming to protocol
    }
    
    //###########################################################
}
