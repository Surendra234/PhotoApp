//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by XP India on 27/12/23.
//

import Foundation

class SignupWebService {
    
    private let urlSession: URLSession
    private let urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        self.urlString = urlString
    }
    
    func signup(withFrom fromModel: SignupFormRequestModel, completion: @escaping (SignupResponseModel?, SignupErrors?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, SignupErrors.invalidRequestURLString)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(fromModel)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let requestError = error {
                completion(nil, SignupErrors.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let data = data, let signupResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completion(signupResponseModel, nil)
            }
            else {
                completion(nil, SignupErrors.invalidResponseModel)
            }
        }
        dataTask.resume()
    }
}
