//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by XP India on 27/12/23.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
