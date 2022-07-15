//
//  SignInViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 12.07.2022.
//

import UIKit
import RealmSwift

class SignInViewController: UIViewController {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var userViewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.value(forKey: "userID"))
        if let user = userViewModel.currentUser {
            redirectUserboard()
        }
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
    @IBAction func signInClick(_ sender: Any) {
        startIndicator()
        let result = userViewModel.signIn(email: emailLabel.text!, password: passwordLabel.text!)
        if result.0 {
            UserDefaults.standard.set(result.1, forKey: "userID")
            redirectUserboard()
        }
        customizedAlert(result)
        stopIndicator()
    }
}

// Indicator
extension SignInViewController{
    func startIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension SignInViewController{
    func redirectUserboard(){
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
}
