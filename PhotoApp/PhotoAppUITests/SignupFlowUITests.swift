//
//  SignupFlowUITests.swift
//  PhotoAppUITests
//
//  Created by XP India on 11/01/24.
//

import XCTest

final class SignupFlowUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupViewController_WhenViewLoaded_RequiredUIElementAreEnable() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let firstName = app.textFields["firstNameTextField"]
        let lastName = app.textFields["lastNameTextField"]
        let emailAddress = app.textFields["emailTextField"]
        let password = app.secureTextFields["passwordTextField"]
        let repatPassword = app.secureTextFields["repatPasswordTextField"]
        let signupButton = app.buttons["signupButton"]
                        
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
        let app = XCUIApplication()
        app.launch()

        let firstName = app.textFields["firstNameTextField"]
        firstName.tap()
        firstName.typeText("S")
        
        let lastName = app.textFields["lastNameTextField"]
        lastName.tap()
        lastName.typeText("M")
        
        let emailAddress = app.textFields["emailTextField"]
        emailAddress.tap()
        emailAddress.typeText("@")
        
        let password = app.secureTextFields["passwordTextField"]
        password.tap()
        password.typeText("12345678")
        
        let repatPassword = app.secureTextFields["repatPasswordTextField"]
        repatPassword.tap()
        repatPassword.typeText("123")
        
        let signupButton = app.buttons["signupButton"]
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].exists, "An error alert dialog was not presented when invalid signup form was submitted")
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