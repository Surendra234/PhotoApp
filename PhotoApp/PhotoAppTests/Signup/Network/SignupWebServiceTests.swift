//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by XP India on 27/12/23.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {

    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        
        signupFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov", email: "test@test.com", password: "12345678")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withFrom: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withFrom: signupFormRequestModel) { (signupResponseModel, error) in
            // Assert
            XCTAssertEqual(error, SignupErrors.invalidResponseModel, "The signup() did not return expected error")
            XCTAssertNil(signupResponseModel, "The response model for a request containt unknown json response, should have been nil")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnError() {
        // Arrange
        let expectation = self.expectation(description: "An empty url string provided")
        sut = SignupWebService(urlString: "")
        
        // Act
        sut.signup(withFrom: signupFormRequestModel) { signupResponseModel, error in
            XCTAssertEqual(error, SignupErrors.invalidRequestURLString, "The signup() method did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes place, the response model must be nil")
            expectation.fulfill()
        }
        // Assert
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupErrors.failedRequest(description: errorDescription)
        
        // Act
        sut.signup(withFrom: signupFormRequestModel) { signupResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignupErrors.failedRequest(description: errorDescription), "The signup() method did not return an expecter error for the Failed Request")
            //XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
}
