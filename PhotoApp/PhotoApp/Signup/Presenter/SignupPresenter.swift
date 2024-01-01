//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by XP India on 30/12/23.
//

import Foundation

class SignupPresenter {
    
    private let fromModelValidator: SignupModelValidatorProtocol
    private let webService: SignupWebServiceProtocol
    private let delegate: SignupViewDeleagteProtocol?
    
    init(fromModelValidator: SignupModelValidatorProtocol,
         webService: SignupWebServiceProtocol,
         delegate: SignupViewDeleagteProtocol
    ) {
        self.fromModelValidator = fromModelValidator
        self.webService = webService
        self.delegate = delegate
    }
    
    func processUserSignup(fromModel: SignupFromModel) {
        if !fromModelValidator.isFirstNameValid(firstName: fromModel.firstName) {
            return
        }
        
        if !fromModelValidator.isLastNameValid(lastName: fromModel.lastName) {
            return
        }
        
        if !fromModelValidator.isValidEmailFormat(email: fromModel.email) {
            return
        }
        
        if !fromModelValidator.isPasswordValid(password: fromModel.password) {
            return
        }
        
        if !fromModelValidator.doPasswordsMatch(password: fromModel.password, repeatPassword: fromModel.repeatPassword) {
            return 
        }
        
        let requestModel = SignupFormRequestModel(firstName: fromModel.firstName, lastName: fromModel.lastName, email: fromModel.email, password: fromModel.password)
        
        webService.signup(withFrom: requestModel) { [weak self] responceModel, error in
            guard let self = self else { return}
            
            if let _ = responceModel {
                self.delegate?.successfullSignup()
                return
            }
        }
    }
}
