//
//  User.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 13.07.2022.
//

import Foundation
import RealmSwift

final class User : Object{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var email : String?
    @Persisted var password: String?
    @Persisted var fullname : String?
    @Persisted var energy: Int?
    @Persisted var level : Int?

    override init() {
        super.init()
    }
}
