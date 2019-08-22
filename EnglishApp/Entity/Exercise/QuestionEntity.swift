//
//  QuestionEntity.swift
//  EnglishApp
//
//  Created by vinova on 6/27/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionEntity : Mappable {
    
    var _id : String?
    var content_extend : String?
    var question_time: String?
    var link_audio : String?
    var sequence : String?
    var answers : [ChildQuestionEntity]?
    var numberClick = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.link_audio <- map["link_audio"]
        self._id <- map["_id"]
        self.sequence <- map["sequence"]
        self.question_time <- map["question_time"]
        self.content_extend <- map["content_extend"]
        self.answers <- map["answers"]
//        self.link_audio = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
    }

    func checkHaveAudio() -> Bool {
        return link_audio == nil ? false : true
    }
}
