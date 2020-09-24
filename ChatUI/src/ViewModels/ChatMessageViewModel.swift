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
    fileprivate let cellId = "id123"
    init (){
        
    }
    func attemptToAssembleGroupedMessages() {
       print("Attempt to group our messages together based on Date property")
       
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
