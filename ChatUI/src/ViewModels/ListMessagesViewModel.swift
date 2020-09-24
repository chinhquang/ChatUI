//
//  ListMessagesViewModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import Foundation
let kUserProfile = UserInfoModel(id: 1, avatar: "https://image2.tienphong.vn/w1200/Uploaded/2020/zaugtn/2018_07_19/tien_phong_mrbean_vbqw.jpg", username: "Mr B")
class ListMessagesViewModel {
    init(model: ConversationModel? = nil) {
        guard let inputModel = model else {
            return
        }
        conversation = inputModel
        
    }
    var messages: [Message] = [Message](){
        didSet {
            self.onUpdateChatConversation?(true)
        }
    }
    
    var conversation: ConversationModel = ConversationModel.init(){
        didSet{
            updateConversation()
        }
    }
    
    var onUpdateChatConversation : BoolHandler?
    var member: Member!
    var chatMate: Member!
    var user : UserInfoModel?

}


extension ListMessagesViewModel {
    func sortMessage (messages : [MessageModel]) -> [MessageModel]{
        let messagesSort = messages.sorted(by: { $0.createDate! < $1.createDate! })
        return messagesSort
    }
    func updateConversation () {
        messages.removeAll()
        guard let messages = conversation.messages else { return }
        for mess in messages{
            let member = Member(id: String(mess.owner?.id ?? 0), name: (mess.owner?.username) ?? "", color: .clear)
            self.messages.append(Message(member: member, text: mess.message ?? "", messageId: UUID().uuidString ))
            
            if mess.owner?.id != 1 {
                user = mess.owner
            }
            
        }
    }
}
