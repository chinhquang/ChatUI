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
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020")),
            ChatMessage(text: "The very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2020")),
            ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "Another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2020")),
            ChatMessage(text: "Newest message today", isIncoming: false, date: Date()),
            ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/16/2020"))
            
            
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
