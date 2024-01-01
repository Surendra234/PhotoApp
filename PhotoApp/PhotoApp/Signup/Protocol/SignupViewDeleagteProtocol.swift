//
//  SignupViewDeleagteProtocol.swift
//  PhotoApp
//
//  Created by XP India on 01/01/24.
//

import Foundation

protocol SignupViewDeleagteProtocol: AnyObject {
    func successfullSignup()
    func errorHandler(error: SignupErrors)
}
