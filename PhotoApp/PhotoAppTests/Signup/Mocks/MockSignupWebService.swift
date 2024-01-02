//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by XP India on 01/01/24.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {

    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func signup(withFrom fromModel: PhotoApp.SignupFormRequestModel, completion: @escaping (PhotoApp.SignupResponseModel?, PhotoApp.SignupErrors?) -> Void) {
        
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completion(nil, .failedRequest(description: "A localize error discreption"))
        }
        else {
            let responceModel = SignupResponseModel(status: "ok")
            completion(responceModel ,nil)
        }
    }
}
