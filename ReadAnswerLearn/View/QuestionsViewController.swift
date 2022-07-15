//
//  QuestionsViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import UIKit
import RealmSwift

class QuestionsViewController: UIViewController {

    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var question3: UILabel!
    @IBOutlet weak var question4: UILabel!
    
    @IBOutlet weak var switch1: UISegmentedControl!
    @IBOutlet weak var switch2: UISegmentedControl!
    @IBOutlet weak var switch3: UISegmentedControl!
    @IBOutlet weak var switch4: UISegmentedControl!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    var questions : [UILabel] = []
    var switches : [UISegmentedControl] = []
    
    var userViewModel = UserViewModel()
    var practiceViewModel = PracticeViewModel()
    var questionViewModel = QuestionViewModel()
    var questionsData : Results<Question>?
    
    var indis : Int = 0
    var correctAnswerCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputConfiguration()
        
        if let user = userViewModel.currentUser {
            if let practice = practiceViewModel.loadByNumber(numb: user.level!){
                questionViewModel.loadByPracticeID(id: practice.id.stringValue)
                questionsData = questionViewModel.datas!

                questionsData!.forEach({ question in
                    questions[indis].text = question.question
                    indis += 1
                })
            }
        }
    }
}

// Click events
extension QuestionsViewController {
    @IBAction func checkClicked(_ sender: Any) {
        checkButton.isEnabled = false

        calculateCorrectAnswers()
        
        checkCorrectAnswers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Redirecting
            self.navigationController?.dismiss(animated: true)
        }
        
    }
}

// Calculates
extension QuestionsViewController{
    private func calculateCorrectAnswers(){
        indis = 0
        questionsData?.forEach({ question in
            if question.answer == switches[indis].selectedSegmentIndex{
                correctAnswerCount += 1
            }
            indis += 1
        })
    }
    
    private func checkCorrectAnswers(){
        if userViewModel.questionsCheck(counter: correctAnswerCount){
            messageLabel.text = "Tebrikler! Alıştırmayı geçtiniz."
            messageLabel.textColor = .systemGreen
        }else{
            messageLabel.text = "Maalesef alıştırmayı geçemediniz..."
            messageLabel.textColor = .systemRed
        }
        
        messageLabel.isHidden = false
    }
}

// Design
extension QuestionsViewController {
    private func inputConfiguration(){
        navigationItem.hidesBackButton = true
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)
        switches.append(switch1)
        switches.append(switch2)
        switches.append(switch3)
        switches.append(switch4)
    }
}
