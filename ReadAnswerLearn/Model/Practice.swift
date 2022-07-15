//
//  Practice.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation
import RealmSwift

final class Practice : Object{
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var number : Int?
    @Persisted var title: String?
    @Persisted var text : String?

    override init() {
        super.init()
    }
}
