//
//  WordViewModel.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation
import RealmSwift

class WordViewModel{
    
    var realm : Realm?
    var datas : Results<Word>?
    var tableName = "words"
    
    init(){
        do{
            self.realm = try Realm()
            print("Connection ok")
        }catch{
            print("Database connection problem")
        }
    }
    
    func save(word : Word) -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.add(word)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func loadByUserID(id: String){
        if let realm = realm {
            do {
                let words = try realm.objects(Word.self).filter("userID = %@", id)
                if words.count > 0 {
                    datas = words
                }
            }catch{
               print("Loading by id not working...")
            }
        }
    }
    
    
}

