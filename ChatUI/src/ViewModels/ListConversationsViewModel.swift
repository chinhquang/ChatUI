//
//  ListConversationsViewModel.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import Foundation
class ListConversationsViewModel {
    init(model: [ConversationModel]? = nil) {
        guard let inputModel = model else {
            return
        }
        conversations = inputModel
    }
    
    var conversations: [ConversationModel] = [ConversationModel]()
}
extension ListConversationsViewModel {
    func fetchConversationList(completion: @escaping (Result<[ConversationModel], Error>) -> Void) {
        
        completion(.success(conversations))
        
        
    }
}
