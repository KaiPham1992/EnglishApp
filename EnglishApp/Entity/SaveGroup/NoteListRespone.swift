//
//  NoteListRespone.swift
//  EnglishApp
//
//  Created by Steve on 7/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

class NoteListRespone : Mappable {
    var total_records : String?
    var notes : [NoteRespone] = []
    func mapping(map: Map) {
        self.total_records <- map["total_records"]
        self.notes <- map["notes"]
    }
    required init?(map: Map) {
        
    }
}
