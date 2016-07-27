//
//  ViewController.swift
//  sandboxlogin
//
//  Created by Chris Schwartz on 7/23/16.
//  Copyright © 2016 Schwartzcode. All rights reserved.
//

import UIKit

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.toWelcomeScreen()
        }
    }
    
    func toWelcomeScreen() {
        self.signingInProgressView.hidden = true;
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController")
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out'", style: UIBarButtonItemStyle.Done, target: self, action: Selector(signOut()))
        presentViewController(viewController, animated: true, completion: { _ in })
    }
    
    func signOut() {
        
    }
}

