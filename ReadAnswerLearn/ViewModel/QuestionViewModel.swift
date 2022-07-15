//
//  QuestionViewModel.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation
import RealmSwift

class QuestionViewModel{
    
    var realm : Realm?
    var datas : Results<Question>?
    var tableName = "questions"
    
    init(){
        do{
            self.realm = try Realm()
            print("Connection ok")
        }catch{
            print("Database connection problem")
        }
    }
    
    func save(question : Question) -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.add(question)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func loadByPracticeID(id: String){
        if let realm = realm {
            do {
                let questions = try realm.objects(Question.self).filter("practiceID = %@", id)
                if questions.count > 0 {
                    datas = questions
                }
            }catch{
               print("Loading by id not working...")
            }
        }
    }
    
    
    
}

