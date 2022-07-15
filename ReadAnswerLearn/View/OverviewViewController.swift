//
//  OverviewViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import UIKit

class OverviewViewController: UIViewController {
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var energyTextLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var savedWordCount: UILabel!
    @IBOutlet weak var endedPracticeCount: UILabel!
    
    var userViewModel = UserViewModel()
    var practiceViewModel = PracticeViewModel()
    var questionViewModel = QuestionViewModel()
    var wordViewModel = WordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = userViewModel.currentUser {
            let countMyWords = wordViewModel.datas?.count ?? 0
            let myLevel = user.level! - 1
            fullnameLabel.text = user.fullname?.capitalized
            energyLabel.text = String(format: "%d/%d", user.energy!, 5)
            progressBar.setProgress(0.2 * Float(user.energy!), animated: true)
            wordViewModel.loadByUserID(id: user.id.stringValue)
            savedWordCount.text = String(countMyWords)
            endedPracticeCount.text = String(myLevel)
        }
    }
}
