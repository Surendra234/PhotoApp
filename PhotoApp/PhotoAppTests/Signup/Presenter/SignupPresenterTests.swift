//
//  SignupPresenterTest.swift
//  PhotoAppTests
//
//  Created by XP India on 30/12/23.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    
    private var signupFromModel: SignupFromModel!
    private var mockSignupModelValidator: MockSignupModelValidator!
    private var mockSignupWebService: MockSignupWebService!
    private var sut: SignupPresenter!
    private var mockSignupViewDelegate: MockSignupViewDelegate!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signupFromModel = SignupFromModel(firstName: "Sergey",
                                              lastName: "Kargopolov",
                                              email: "test@test.com",
                                              password: "12345678",
                                              repeatPassword: "12345678")
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        
        sut = SignupPresenter(fromModelValidator: mockSignupModelValidator, 
                              webService: mockSignupWebService,
                              delegate: mockSignupViewDelegate
        )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signupFromModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperties() {
        // Arrange
        // Act
        sut.processUserSignup(fromModel: signupFromModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailFormateValidated, "Email formate was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordEqualityValidated, "Did not validate if password match")
    }
    
    func testSignupPresenter_WhenGivenValidFromModel_ShouldCalledSignupMethod() {
        // Arrange
        // Act
        sut.processUserSignup(fromModel: signupFromModel)
        
        // Assert
        XCTAssert(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the signupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOpreationSuccessful_CallsSuccessOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected the successfulSignup() method to be called")
        
        mockSignupViewDelegate.expectation = myExpectation
        
        // Act
        sut.processUserSignup(fromModel: signupFromModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
    }
}
