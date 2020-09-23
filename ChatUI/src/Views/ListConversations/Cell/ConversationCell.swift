//
//  ConversationCell.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {
    static let reuseIdentifier : String = "ConversationCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var usernameLabel: UILabelHelper!
    @IBOutlet weak var messageLabel: UILabelHelper!
    @IBOutlet weak var timeLabel: UILabelHelper!
    @IBOutlet weak var avatarImageView: UIImageView!
}
