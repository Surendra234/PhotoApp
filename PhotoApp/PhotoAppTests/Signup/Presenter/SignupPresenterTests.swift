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
        mockSignupViewDelegate = nil
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
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The successful signup() was called more then one time")
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        mockSignupViewDelegate.expectation = expectation
        mockSignupWebService.shouldReturnError = true
        
        // Act
        sut.processUserSignup(fromModel: signupFromModel)
        self.wait(for: [expectation], timeout: 2)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlerCounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
    }
    
    func testSignupPresenter_WhenProvidedInvalidaCharcater_ThrowsAnError() {
//        XCTAssertThrowsError(try sut.isFirstNameValid("Surendra#"), "The isFirstNameValid() should throw an error when first name containt illigale charcter") { error in
//            XCTAssertEqual(error as? SignupErrors?, SignupErrors.illigleCharaterFound)
//        }
        
        do {
            let _ = try sut.isFirstNameValid("Surendra@")
            XCTFail("The isFirstNameValid() was supposed to throw an error when firstName containt illage charcter")
        }
        catch SignupErrors.illigleCharaterFound {
            // successfull passign
            return
        }
        catch {
            XCTFail("The isFirstNameValid() was supposed to throw an SignupErrors.illigleCharaterFound when firstName containt illigle charcter, An throw diffrent error")
            return
        }
    }
    
    func testSignupPresenter_WhenValidCharcterProvided_ThrowaNoError() {
        XCTAssertNoThrow(try sut.isFirstNameValid("Surendra"), "The isFirstNameValid() should throw no error when first name containt valid charcter")
    }
}
