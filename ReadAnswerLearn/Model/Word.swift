//
//  Word.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//
import Foundation
import RealmSwift

final class Word : Object{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var turkish : String?
    @Persisted var english: String?
    @Persisted var userID: String?

    override init() {
        super.init()
    }
}

