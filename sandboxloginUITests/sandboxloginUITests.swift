//
//  sandboxloginUITests.swift
//  sandboxloginUITests
//
//  Created by Chris Schwartz on 7/23/16.
//  Copyright © 2016 Schwartzcode. All rights reserved.
//

import XCTest

class sandboxloginUITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfulSignIn() {
        //Note: if running in simulator, make sure that option to 'Connect hardware keyboard' is off, or you may encounter problems when this test tries to enter text into field.
        
        // Enter username
        let userNameInput = app.textFields["UsernameTextField"]
        userNameInput.tap()
        userNameInput.typeText("SomeUser")
        
        // Enter a password
        let passwordInput = app.secureTextFields["PasswordTextField"]
        passwordInput.tap()
        passwordInput.typeText("MySecretPassword")
        
        // Press sign in button
        let signInButton = app.buttons["SignInButton"]
        signInButton.tap()
        
        // Verify progress indicator is shown.  This will happen immediately while waiting for the login to complete
        let loadingIndicator = app.activityIndicators["In progress"]
        XCTAssertTrue(loadingIndicator.exists)
        
        // Set up an expectation.  We expect to see the text letting us know the sign in was successful.
        let signedInText = app.staticTexts["SuccessfulSignInText"]
        expectationForPredicate(NSPredicate(format: "exists == 1"), evaluatedWithObject: signedInText, handler: nil)
        
        // Wait until our expectation is fulfilled or we exceed 5 seconds.
        waitForExpectationsWithTimeout(5, handler: nil)
        
        // Assert there is a sign out button present.
        let signOutButton = app.buttons["Sign out"]
        XCTAssertTrue(signOutButton.exists)
    }
    
}
