//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by XP India on 02/01/24.
//

import XCTest
@testable import PhotoApp

final class SignupViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
    }
    
    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to IBOuttlet")
        
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to IBOuttlet")
        let emailNameTextField = try XCTUnwrap(sut.emailTextField, "The emailNameTextField is not connected to IBOuttlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to IBOuttlet")
        let repatPasswordTextField = try XCTUnwrap(sut.repatPasswordTextField, "The repatPasswordTextField is not connected to IBOuttlet")
        
        XCTAssertEqual(sut.firstNameTextField.text, "", "first name textfield was not empty when view controller initially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "last name textfield was not empty when view controller initially loaded")
        XCTAssertEqual(sut.emailTextField.text, "", "email textfield was not empty when view controller initially loaded")
        XCTAssertEqual(sut.passwordTextField.text, "", "password textfield was not empty when view controller initially loaded")
        XCTAssertEqual(sut.repatPasswordTextField.text, "", "repat password textfield was not empty when view controller initially loaded")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "Signup button does not have an refrence outlet")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "signup button does not have any action to assign to it")
        
        // Assert
        XCTAssertEqual(signupButtonActions.count, 1)
        XCTAssertTrue((signupButtonActions.first != nil), "signupButtonTapped", file: "There is no action with a name signupButtonTapped assign to signup button")
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokesSignupAction() {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(fromModelValidator: mockSignupModelValidator, webService: mockWebService, delegate: mockSignupViewDelegate)
        
        // Act
        sut.signupPresenter = mockSignupPresenter
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled, "The processUserSignup was not called on a presenter object when the sigup button was tapped in a signup viewcontroller")
    }
}
