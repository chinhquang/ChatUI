//
//  ConversationModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper

class ConversationModel {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map ["message"]
        owner <- map ["owner"]
        createdAt <- map ["createdAt"]
        updatedAt <- map ["updatedAt"]
        toUser <- map ["toUser"]
    }
    var message : String?
    var createdAt: TimeInterval?
    var owner: UserInfoModel?
    var toUser : UserInfoModel?
    var updatedAt : TimeInterval?
}
