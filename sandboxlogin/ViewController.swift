//
//  ViewController.swift
//  sandboxlogin
//
//  Created by Chris Schwartz on 7/23/16.
//  Copyright © 2016 Schwartzcode. All rights reserved.
//

import UIKit

// Simulates a login screen and the delay that may be experienced if actual network calls were being made. Currently, when sign in button is pressed, 
// we just wait for a bit of time and then go to the welcome screen. The actual input for the username/password doesn't matter, sign in will always be 
// treated as successful. This is only meant to give us something to write a test against and demonstrate how expectations can be used, this should never 
// be used in production.

class ViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var signInControlsView: UIView!
    @IBOutlet weak var signingInProgressView: UIStackView!
    
    @IBAction func onSignInButtonPressed(sender: AnyObject) {
        showLoading()
        pretendLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInControlsView.hidden = false
        signingInProgressView.hidden = true
    }
    
    func showLoading() {
        
        signingInProgressView.hidden = false
        signingInProgressView.alpha = 0.0
        
        UIView.animateWithDuration(0.075, animations: { _ in
            self.signingInProgressView.alpha = 1.0
            self.signInControlsView.alpha = 0.0
            }, completion:   { _ in
                self.signInControlsView.hidden = true
                self.signingInProgressView.hidden = false
        })
    }
    
    func showSignIn() {
        self.signingInProgressView.hidden = true
        self.signInControlsView.hidden = false
    }
    
    func pretendLogin() {
        // Not really doing anything with sign in information, just waiting to simulate the delay we might experience if we were to sign into an actual server
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.showWelcomeScreen()
        }
    }
    
    func showWelcomeScreen() {
        self.signingInProgressView.hidden = true;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController")
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out'", style: UIBarButtonItemStyle.Done, target: self, action: Selector(signOut()))
        presentViewController(viewController, animated: true, completion: { _ in })
    }
    
    func signOut() {
        // no need to actually do anything here, segue defined in storyboard will simply take us back to sign in screen.
    }
}

