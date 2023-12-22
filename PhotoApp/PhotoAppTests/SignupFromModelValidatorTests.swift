//
//  SignupFromModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by XP India on 22/12/23.
//

import XCTest
@testable import PhotoApp

final class SignupFromModelValidatorTests: XCTestCase {
    
    var sut: SignupFromModelValidator!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFromModelValidator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    // MARK: - first name
    
    func testSignupFromModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Surendra")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have return TRUE for a vaild first name but returned FALSE")
    }
    
    func testSignupFromModelValidator_WhenTooShortFirstNameProvided_ShouldRetuenFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "s")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have return FALSE for a first name that is shorter then \(SignupConstants.firstNameMinLength) charcters but it has returned TRUE")
    }
    
    func testSignupFromModelValidator_WhenLongFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Surendra Mahawar")
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have return FALSE for a first name that is longer then \(SignupConstants.firstNameMaxLength) charcters but it has returned TRUE")
    }
    
    // MARK: - last name
    
    func testSignupFromModelValidator_WhenValidLastNameProvided_ShouldReturnTrue() {
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Mahawar")
        // Assert
        XCTAssertTrue(isLastNameValid, "The isLastNameValid() should have return TRUE for a valid last name but returned FALSE")
    }
    
    func testSignupFromModelValidator_WhenTooShortLastNameProvided_ShouldReturnFalse() {
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "M")
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have return FALSE for a last name that is shorter then \(SignupConstants.lastNameMinLength) charcaters but it has returned TRUE")
    }
    
    func testSignupFromModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Mahawar Singh")
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() should have return FALSE for a last name that is longer then \(SignupConstants.lastNameMaxLength) charcaters but it has returned TRUE")
    }
    
    // MARK: - email
    
    func testSignupFromModelValidator_WhenValidEmailProvided_ShouldReturnTrue() {
        // Act
        let isValidEmailFormat = sut.isValidEmailFormat(email: "surendra@gmail.com")
        // Assert
        XCTAssertTrue(isValidEmailFormat, "The isValidEmailFormat() should have return TRUE for a valid email but it return FALSE")
    }
    
    func testSignupFromModelValidator_WhenInvalidEmailProvided_ShouldReturnFalse() {
        // Act
        let isValidEmailFormat = sut.isValidEmailFormat(email: "sure@gmail")
        // Assert
        XCTAssertFalse(isValidEmailFormat, "The isValidEmailFormat() should have return FALSE for a invalid email but it return TRUE")
    }
    
    // MARK: - password
    
    func testSignupFromModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "12345678")
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password  but it has returned FALSE")
    }
    
    func testSignupFromModelValidator_WhenTooShortPasswordProvided_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "123")
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is shorter than \(SignupConstants.passwordMinLength) but it has returned TRUE")
    }
    
    func testSignupFromModelValidator_WhenTooLongPasswordProvided_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid(password: "1236425476236482638")
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE for a password that is longer than \(SignupConstants.passwordMaxLength) but it has returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "12345678")
        // Assert
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch() should have returned TRUE for matching passwords but it has returned FALSE")
    }
    
    func testSignupFromModelValidator_WhenNotMatchingPasswordProvided_ShouldReturnFalse() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(password: "12345678", repeatPassword: "123456789")
        // Assert
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() should have returned FALSE for passwords that do not match but it has returned TRUE")
    }
}
