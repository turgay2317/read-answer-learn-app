//
//  PracticeViewModel.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation
import RealmSwift

class PracticeViewModel{
    
    var realm : Realm?
    var datas : Results<Practice>?
    var tableName = "practices"
    
    init(){
        do{
            self.realm = try Realm()
            print("Connection ok")
        }catch{
            print("Database connection problem")
        }
    }
    
    func save(practice : Practice) -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.add(practice)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func deleteAll() -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.delete(datas!)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func load(){
        if let realm = realm {
            datas = realm.objects(Practice.self)
        }
    }
    
    func loadByID(id: String) -> Practice?{
        if let realm = realm {
            do {
                let practice = try realm.object(ofType: Practice.self, forPrimaryKey: ObjectId(string: id))
                return practice
            }catch{
               print("Loading by id not working...")
            }
        }
        return Practice()
    }
    
    func loadByNumber(numb: Int) -> Practice?{
        if let realm = realm {
            do {
                let practice = try realm.objects(Practice.self).filter("number = %d", numb)
                return practice.first ?? Practice()
            }catch{
               print("Loading by number not working...")
            }
        }
        return Practice()
    }
    
}

