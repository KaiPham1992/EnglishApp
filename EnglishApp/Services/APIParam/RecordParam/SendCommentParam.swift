//
//  SendCommentParam.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 1/9/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class SendCommentParam: BaseParam {
    var recordId        : String?
    var comment         : String?
    var commentId       : String?
    var isReComment     : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.recordId       <- map["record_id"]
        self.comment        <- map["comment"]
        self.commentId      <- map["comment_id"]
        self.isReComment    <- map["is_re_cmt"]
        
    }
    
    init(recordId         : String? = nil,
         comment          : String? = nil,
         commentId        : String? = nil,
         isReComment      : String? = nil) {
        super.init()
        self.recordId         = recordId
        self.comment          = comment
        self.commentId        = commentId
        self.isReComment      = isReComment
    }
   
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
