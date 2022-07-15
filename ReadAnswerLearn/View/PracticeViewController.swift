//
//  PracticeViewController.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import UIKit

class PracticeViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    
    private var words : [String] = []
    private var x : Int = 20
    private var y : Int = 100
    private var tipCounter : Int = 5
    var paragraphText : String = ""
    
    var userViewModel = UserViewModel()
    var practiceViewModel = PracticeViewModel()
    var wordViewModel = WordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = userViewModel.currentUser {
            if let practice = practiceViewModel.loadByNumber(numb: user.level!){
                paragraphText = practice.text!
                loadParagraph()
                tipLabelRefresh()
                createNavBar()
                createWords()
            }
        }
    }
}

// Design
extension PracticeViewController{
    private func createNavBar(){
        let rightButton = UIBarButtonItem(title: "Devam", style: .plain, target: self, action: #selector(goQuestions))
        rightButton.tintColor = .systemGreen
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    private func createWords(){
        for (index,word) in words.enumerated() {
            let btn = UIButton()
            // Button style
            btn.setTitle(word, for: .normal)
            btn.backgroundColor = .white
            btn.setTitleColor(.black, for: .normal)
            btn.frame = CGRect(x: self.x, y: self.y, width: word.count * 15, height: 30)
            // Button position, line
            if self.x + (word.count * 15) + 60 > Int(self.view.bounds.width) {
                self.y += 30
                self.x = 20
            }else{
                self.x += (word.count * 15)
            }
            // Button attributes
            btn.tag = index
            btn.addTarget(self, action: #selector(clickWord), for: .touchDown)
            view.addSubview(btn)
        }
    }
    
    private func loadParagraph(){
        words = self.paragraphText.components(separatedBy: " ")
    }
    
    private func tipLabelRefresh(){
        tipLabel.text = String(format: "İpucu: %d/%d", tipCounter, 5)
    }
    
    private func alertWord(title : String, tuple : (Bool, String)){
        let alert = UIAlertController(title: title, message: tuple.1, preferredStyle: .alert)
        let btnClose = UIAlertAction(title: "OK", style: .default)
        let btnAdd = UIAlertAction(title: "Defter ekle", style: .default) { [self] handler in
            let myNewWord = Word()
            myNewWord.userID = userViewModel.currentUser?.id.stringValue
            myNewWord.turkish = tuple.1
            myNewWord.english = title
            wordViewModel.save(word: myNewWord)
            wordViewModel.loadByUserID(id: myNewWord.userID!)
        }
        if tuple.0 == true {
            alert.addAction(btnAdd)
        }
        alert.addAction(btnClose)
        self.present(alert, animated: true)
    }
}

// Click events
extension PracticeViewController {
    @objc func goQuestions(){
        performSegue(withIdentifier: "toQuestionsSegue", sender: nil)
    }
    
    @objc func clickWord(sender : UIButton){
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        
        if tipCounter > 0 {
            let translateResult = TranslateService.translate(words[sender.tag], limit: 2)
            alertWord(title:words[sender.tag], tuple: translateResult)
            if translateResult.0 == true{
                tipCounter -= 1
                tipLabelRefresh()
            }
        }else{
            alertWord(title: "Hata", tuple: (false,"Maalesef ipucu hakkınız kalmadı"))
        }
    }
}
