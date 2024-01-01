//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by XP India on 01/01/24.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withFrom fromModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupErrors?) -> Void)
}
