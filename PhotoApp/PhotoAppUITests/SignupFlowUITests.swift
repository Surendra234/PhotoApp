//
//  SignupFlowUITests.swift
//  PhotoAppUITests
//
//  Created by XP India on 11/01/24.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var emailAddress: XCUIElement!
    private var password: XCUIElement!
    private var repatPassword: XCUIElement!
    private var signupButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        emailAddress = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repatPassword = app.secureTextFields["repatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        app = nil
        firstName = nil
        lastName = nil
        emailAddress = nil
        password = nil
        repatPassword = nil
        signupButton = nil
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementAreEnable() throws {
        // UI tests must launch the application that they test.
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(firstName.isEnabled, "firstName textField is not enable")
        XCTAssertTrue(lastName.isEnabled, "lastName textField is not enable")
        XCTAssertTrue(emailAddress.isEnabled, "emailAddress textField is not enable")
        XCTAssertTrue(password.isEnabled, "password textField is not enable")
        XCTAssertTrue(repatPassword.isEnabled, "repatPassword textField is not enable")
        XCTAssertTrue(signupButton.isEnabled, "signupButton textField is not enable")
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        // Arrange
        firstName.tap()
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("M")
        
        emailAddress.tap()
        emailAddress.typeText("@")
        
        password.tap()
        password.typeText("12345678")
        
        repatPassword.tap()
        repatPassword.typeText("123")
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "An error alert dialog was not presented when invalid signup form was submitted")
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsSuccessAlertDialog() {
        // Arrange
        firstName.tap()
        firstName.typeText("Surendra")
        
        lastName.tap()
        lastName.typeText("Mahawar")
        
        emailAddress.tap()
        emailAddress.typeText("surendra@gmail.com")
        
        password.tap()
        password.typeText("12345678")
        
        repatPassword.tap()
        repatPassword.typeText("12345678")
                
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1), "An success alert dialog was not presented when valid signup form was submitted")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
