//
//  ConversationModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper
import MessageKit

class ConversationModel : Mappable {
    init (){}
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map ["message"]
        messages <- map ["messages"]
        
    }
    
    var message : MessageModel?
    var messages : [MessageModel]?
}

class MessageModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        message <- map ["message"]
        createDate <- map ["createDate"]
        owner <- map ["owner"]
    }
    
    var id: String?
    var message: String?
    var createDate : TimeInterval?
    var owner: UserInfoModel?
}

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}
