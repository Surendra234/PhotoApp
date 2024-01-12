//
//  SignupErrors.swift
//  PhotoApp
//
//  Created by XP India on 27/12/23.
//

import Foundation

enum SignupErrors: LocalizedError, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case illigleCharaterFound
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidPassword
    case invalidRepeatPassword
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel,
             .invalidRequestURLString,
             .illigleCharaterFound,
             .invalidFirstName,
             .invalidLastName,
             .invalidEmail,
             .invalidPassword,
             .invalidRepeatPassword:
            return ""
        }
    }
}
