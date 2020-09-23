//
//  ListConversationsViewController.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit

class ListConversationsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = kListConversationScreenTitle
    }

    
    @IBOutlet weak var tableView: UITableView!
}

extension ListConversationsViewController: UITableViewDelegate{
    
}
extension ListConversationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
