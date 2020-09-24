//
//  ChatMessageViewController.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/25/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper

extension UIScrollView {

    func scrollToBottom(animated: Bool) {
        var y: CGFloat = 0.0
        let HEIGHT = self.frame.size.height
        if self.contentSize.height > HEIGHT {
            y = self.contentSize.height - HEIGHT
        }
        self.setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
}
class ChatMessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate let cellId = "id123"
    @IBOutlet weak var messageInputContainerView: UIView!
    @IBOutlet weak var inputTextField: UITextfieldHelper!
    
    
    @IBOutlet weak var bottomContraints: NSLayoutConstraint!
    
    var chatMessages = [[ChatMessage]]()
    
    var messagesFromServer = [
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false, date: Date()),
        ChatMessage(text: "This message should appear on the left with a white background bubble", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Third Section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018"))
        ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.scrollToBottom(animated: true)
    }
    
    fileprivate func attemptToAssembleGroupedMessages() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptToAssembleGroupedMessages()
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func handleKeyboardNotification(notification : Notification) {
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomContraints.constant = isShowing ? keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completion) in
                self.tableView.scrollToBottom(animated: true)

                
            })
        }
    }
}

extension ChatMessageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
        
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false // enables auto layout
            font = UIFont.boldSystemFont(ofSize: 14 * kWidthRatio)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
        
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first {
            
            let dateString = firstMessageInSection.date.getDateString(with: "dd/MM/yyyy")
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView
            
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
//        let chatMessage = chatMessages[indexPath.row]
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        cell.selectionStyle = .none
        return cell
    }

}
extension ChatMessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
}

