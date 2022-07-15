//
//  SignoutViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import UIKit

class SignoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "userID")
        performSegue(withIdentifier: "toLoginScreenSegue", sender: nil)
    }
    
}
