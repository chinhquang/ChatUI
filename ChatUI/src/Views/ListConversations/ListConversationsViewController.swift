//
//  ListConversationsViewController.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit

class ListConversationsViewController: BaseViewController {

    var conversationsViewModel: ListConversationsViewModel = ListConversationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = kListConversationScreenTitle
        // Set up tableview
        tableView.register(UINib(nibName: ConversationCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ConversationCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        conversationsViewModel.fetchConversationList{ [weak self] result in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
}

//MARK: - UITableViewDelegate conforming methods
extension ListConversationsViewController: UITableViewDelegate{
    
}
//MARK: - UITableViewDatasource conforming methods
extension ListConversationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        conversationsViewModel.conversations.count
        if conversationsViewModel.conversations.count == 0 {
            tableView.setEmptyView(title: "Empty history", message: "There is no chat history")
        } else {
            tableView.restore()
        }
        return conversationsViewModel.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.reuseIdentifier, for: indexPath) as! ConversationCell
        return cell
    }
    
    
}
