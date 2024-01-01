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
    
    func signup(withFrom fromModel: PhotoApp.SignupFormRequestModel, completion: @escaping (PhotoApp.SignupResponseModel?, PhotoApp.SignupErrors?) -> Void) {
        
        isSignupMethodCalled = true
    }
}
