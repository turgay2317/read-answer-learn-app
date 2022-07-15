//
//  Question.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation
import RealmSwift

final class Question : Object{
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var question : String?
    @Persisted var answer : Int? // 0 true, 1 false why because inputs located like that
    @Persisted var practiceID : String?
    
    override init() {
        super.init()
    }
}
    

