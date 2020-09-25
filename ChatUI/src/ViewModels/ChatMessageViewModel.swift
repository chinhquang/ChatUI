//
//  ChatMessageViewModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/25/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import Foundation

class ChatMessageViewModel {
    var chatMessages = [[ChatMessage]]()

    var messagesFromServer = [
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message with image today", isIncoming: true, date: Date() , type: MessageType.image(imageURL: "https://media.blendernation.com/wp-content/uploads/2020/06/Blender283_SplashScreen.jpg")),
            ChatMessage(text: "Newest message with image today", isIncoming: false, date: Date() , type: MessageType.image(imageURL: "https://media.blendernation.com/wp-content/uploads/2020/06/Blender283_SplashScreen.jpg")),
            ChatMessage(text: "Newest message with video today", isIncoming: true, date: Date.dateFromCustomString(customString: "09/20/2020") , type: MessageType.video(videoURL: "http://video.dailymail.co.uk/video/mol/test/2016/09/21/5739239377694275356/1024x576_MP4_5739239377694275356.mp4"))
            
            ]

    fileprivate let cellId = "id123"
    
    init (){
        
    }
    func attemptToAssembleGroupedMessages() {
       print("Attempt to group our messages together based on Date property")
        chatMessages.removeAll()
       let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
           return element.date.reduceToMonthDayYear()
       }
       
       // provide a sorting for your keys somehow
       let sortedKeys = groupedMessages.keys.sorted()
       sortedKeys.forEach { (key) in
           let values = groupedMessages[key]
           chatMessages.append(values ?? [])
       }
   }
}
