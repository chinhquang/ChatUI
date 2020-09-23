//
//  UserInfoModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfoModel : Mappable{
    var avatar: String?
    var username: String?
    var id : Int?
    init(avatar: String, username: String) {
        self.avatar = avatar
        self.username = username
    }
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        id <- map["id"]
        username <- map ["username"]
        avatar <- map["avatar"]
    }
}
