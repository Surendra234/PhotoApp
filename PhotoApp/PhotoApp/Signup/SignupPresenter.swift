//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by XP India on 30/12/23.
//

import Foundation

class SignupPresenter {
    
    private let fromModelValidator: SignupModelValidatorProtocol
    
    init(fromModelValidator: SignupModelValidatorProtocol) {
        self.fromModelValidator = fromModelValidator
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
    }
}
