//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by XP India on 02/01/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var signupPresenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if signupPresenter == nil {
            let signupModelValidator = SignupFromModelValidator()
            let webService = SignupWebService(urlString: SignupConstants.signupURLString)
            
            signupPresenter = SignupPresenter(fromModelValidator: signupModelValidator,
                                              webService: webService,
                                              delegate: self)
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let signupFromModel = SignupFromModel(firstName: firstNameTextField.text ?? "", 
                                              lastName: lastNameTextField.text ?? "",
                                              email: emailTextField.text ?? "",
                                              password: passwordTextField.text ?? "",
                                              repeatPassword: repatPasswordTextField.text ?? "")
        
        signupPresenter?.processUserSignup(fromModel: signupFromModel)
    }
}

extension SignupViewController: SignupViewDeleagteProtocol {
    func successfullSignup() {
        // TODO:
    }
    
    func errorHandler(error: SignupErrors) {
        let alert = UIAlertController(title: "Error", message: "Your request could not be processed at this time", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
}
