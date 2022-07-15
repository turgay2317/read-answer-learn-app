//
//  SignUpViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 12.07.2022.
//

import UIKit
import RealmSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullnameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    @IBAction func signupClick(_ sender: Any) {
        startIndicator()
        
        let result = userViewModel.signUp(fullname: fullnameLabel.text!,email: emailLabel.text!,password: passwordLabel.text!)
        
        customizedAlert(result)
        
        stopIndicator()
    }
}

// Indicator
extension SignUpViewController{
    func startIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

// Form Validation
extension SignUpViewController{    
    func resetInputs(){
        fullnameLabel.text = ""
        emailLabel.text = ""
        passwordLabel.text = ""
    }
}
