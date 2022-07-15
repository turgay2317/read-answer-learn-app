//
//  Level.swift
//  ReadAnswerLearn
//
//  Created by Turgay Ceylan on 14.07.2022.
//

import Foundation

struct Level : Codable{
    var documentID : String = ""
    var levelID : String?
    var levelTitle : String?
    var levelText : String?
    var levelNumber : Int?
    
    var dictionary: [String: Any] {
        var dict = [
            "levelID": levelID,
            "levelTitle": levelTitle,
            "levelText": levelText,
            "levelNumber": levelNumber
        ] as [String : Any]
        if documentID != "" {
            dict["documentID"] = documentID
        }
        return dict
    }
}
