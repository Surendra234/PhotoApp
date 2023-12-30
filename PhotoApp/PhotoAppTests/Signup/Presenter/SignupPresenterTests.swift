//
//  SignupPresenterTest.swift
//  PhotoAppTests
//
//  Created by XP India on 30/12/23.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperties() {
        // Arrange 
        let signupFromModel = SignupFromModel(firstName: "Sergey",
                                              lastName: "Kargopolov",
                                              email: "test@test.com",
                                              password: "12345678",
                                              repeatPassword: "12345678")
        
        let mockSignupModelValidator = MockSignupModelValidator()
        
        let sut = SignupPresenter(fromModelValidator: mockSignupModelValidator)
        
        // Act
        sut.processUserSignup(fromModel: signupFromModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailFormateValidated, "Email formate was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Did not validate if password match")
    }
}
