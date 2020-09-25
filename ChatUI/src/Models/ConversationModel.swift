//
//  ConversationModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper

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

enum MessageType {
    case text
    case image(imageURL : String)
    case video(videoURL : String)
    
    
}
struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
    var type : MessageType = .text
}
