//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by XP India on 01/01/24.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDeleagteProtocol {
    var expectation: XCTestExpectation?
    var successfulSignupCounter = 0
    var errorHandlerCounter = 0
    var signupError: SignupErrors?
    
    func successfullSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: PhotoApp.SignupErrors) {
        signupError = error
        errorHandlerCounter += 1
        expectation?.fulfill()
    }
}

