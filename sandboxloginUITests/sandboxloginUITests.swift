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
        let userNameInput = app.textFields["UsernameTextField"]
        
        userNameInput.tap()
        userNameInput.typeText("SomeUser")
        
        let passwordInput = app.secureTextFields["PasswordTextField"]
        passwordInput.tap()
        passwordInput.typeText("MySecretPassword")
        
        let signInButton = app.buttons["SignInButton"]
        signInButton.tap()
        
        let loadingIndicator = app.activityIndicators["In progress"]
        XCTAssertTrue(loadingIndicator.exists)
        
        let signedInText = app.staticTexts["SuccessfulSignInText"]
        
        expectationForPredicate(NSPredicate(format: "exists == 1"), evaluatedWithObject: signedInText, handler: nil)
        
        waitForExpectationsWithTimeout(5, handler: nil)
        
        let signOutButton = app.buttons["Sign out"]
        XCTAssertTrue(signOutButton.exists)
    }
    
}
