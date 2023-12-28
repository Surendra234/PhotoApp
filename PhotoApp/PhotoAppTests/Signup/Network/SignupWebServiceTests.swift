//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by XP India on 27/12/23.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let sut = SignupWebService(urlString: SignupConstants.signupURLString)
        let signupFormRequestModel = SignupFormRequestModel()
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withFrom: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            //"{\"status\":\"ok\"}"
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
}
