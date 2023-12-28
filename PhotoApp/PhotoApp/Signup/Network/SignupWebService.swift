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
            // TODO.. to create a unit test to test that a specific error message is returned is URL is nil
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(fromModel)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            // TODO.. write a unit test to handle error here
            
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
