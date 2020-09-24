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
    
    var message: MessageModel? {
        didSet {
            guard let message = self.message else {
                return
            }
            usernameLabel.text = message.owner?.username
            messageLabel.text = message.message
            timeLabel.text = Date.init(timeIntervalSince1970: message.createDate!).getDateString(with: "hh:mm aaa")
            avatarImageView.setImage(imgURL: message.owner?.avatar ?? "", placeHolderImage: #imageLiteral(resourceName: "user"))
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabelHelper!
    @IBOutlet weak var messageLabel: UILabelHelper!
    @IBOutlet weak var timeLabel: UILabelHelper!
    @IBOutlet weak var avatarImageView: UIImageView!
}
