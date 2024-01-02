//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by XP India on 02/01/24.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    
    init(fromModelValidator: SignupModelValidatorProtocol,
         webService: SignupWebServiceProtocol,
         delegate: SignupViewDeleagteProtocol
    )
    
    func processUserSignup(fromModel: SignupFromModel)
}
