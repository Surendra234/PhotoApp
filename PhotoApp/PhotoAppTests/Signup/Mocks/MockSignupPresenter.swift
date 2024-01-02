//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by XP India on 02/01/24.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    
    var processUserSignupCalled: Bool = false
    
    required init(fromModelValidator: PhotoApp.SignupModelValidatorProtocol, webService: PhotoApp.SignupWebServiceProtocol, delegate: PhotoApp.SignupViewDeleagteProtocol) {
        // TODO..
    }
    
    func processUserSignup(fromModel: PhotoApp.SignupFromModel) {
        processUserSignupCalled = true
    }
}
