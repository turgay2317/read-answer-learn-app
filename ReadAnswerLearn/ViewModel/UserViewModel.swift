//
//  UserViewModel.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import Foundation
import RealmSwift

class UserViewModel{
    
    var realm : Realm?
    var datas : Results<User>?
    var currentUser : User?
    var tableName = "users"
    
    init(){
        do{
            self.realm = try Realm()
            if let userID = UserDefaults.standard.value(forKey: "userID"){
                currentUser = loadByID(id: userID as! String)
            }
            print("Connection ok")
        }catch{
            print("Database connection problem")
        }
    }
    
    func save(user : User) -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.add(user)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func update(user : User) -> Bool{
        if let realm = realm {
            do{
                try realm.write({
                    realm.add(user, update: .modified)
                })
            }catch{
                return false
            }
        }
        return true
    }
    
    func decreaseEnergy() -> Bool{
        if let realm = realm {
            if let currentUser = currentUser {
                do{
                    try realm.write({
                        currentUser.energy! -= 1
                    })
                    return update(user: currentUser)
                }catch{
                   return false
                }
            }
        }
        return false
    }
    
    func increaseLevel() -> Bool{
        if let realm = realm {
            if let currentUser = currentUser {
                do{
                    try realm.write({
                        currentUser.level! += 1
                    })
                    return update(user: currentUser)
                }catch{
                   return false
                }
            }
        }
        return false
    }
    
    func questionsCheck(counter: Int) -> Bool{
        if counter >= 3 {
           return increaseLevel()
        }
        return false
    }
    
    func practiceCheck() -> Bool{
        if let realm = realm {
            if let currentUser = currentUser {
                if currentUser.energy! > 0 {
                    return decreaseEnergy()
                }
            }
        }
        return false
    }
    
    func load(){
        if let realm = realm {
            datas = realm.objects(User.self)
        }
    }
    
    func loadByID(id: String) -> User?{
        if let realm = realm {
            do {
                let user = try realm.object(ofType: User.self, forPrimaryKey: ObjectId(string: id))
                return user
            }catch{
               print("Loading by id not working...")
            }
        }
        return User()
    }
    
    func signUp(fullname : String, email : String, password : String) -> (Bool, String){
        if validation(values: [fullname, email, password]){
            let user = User()
            user.fullname = fullname
            user.email = email
            user.password = password
            user.level = 1
            user.energy = 5
            
            if save(user: user){
                return (true, "Kayıt başarılı")
            }else{
                return (false, "Beklenmedik bir hata oluştu")
            }
        
        }else{
            return (false, "Tüm alanları doldurunuz")
        }
    }
    
    func signIn(email : String, password: String) -> (Bool, String) {
        if validation(values: [email, password]){
            if let realm = realm {
                let user = realm.objects(User.self).filter("email = %@ && password = %@", email, password)
                return user.count > 0 ? (true, user[0].id.stringValue) : (false, "Kullanıcı adı veya şifre yanlış")
            }
            return (false, "Bağlantı hatası")
        }else{
            return (false, "Tüm alanları doldurunuz")
        }
    }
    
}

// Validations
extension UserViewModel{
    func validation(values: [String]) -> Bool{
        var isValid = true
        for value in values {
            if value.isEmpty {
                isValid = false
                break
            }
        }
        return isValid
    }
}
    

