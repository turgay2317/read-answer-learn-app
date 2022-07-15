//
//  ViewController+Extensions.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func alert(title : String, text : String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let btnClose = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btnClose)
        self.present(alert, animated: true)
    }
    
    func customizedAlert(_ tuple: (Bool, String)){
        let alert = UIAlertController(title: tuple.0 == true ? "Mesaj" : "Hata", message: tuple.1, preferredStyle: .alert)
        let btnClose = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btnClose)
        self.present(alert, animated: true)
    }
}
