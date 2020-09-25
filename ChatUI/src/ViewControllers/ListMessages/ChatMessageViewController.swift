//
//  ChatMessageViewController.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/25/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import ObjectMapper

class ChatMessageViewController: BaseViewController {
    
    //MARK:- Properties and IBOutlet declarations
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageInputContainerView: UIView!
    @IBOutlet weak var inputTextField: UITextfieldHelper!
    @IBOutlet weak var bottomContraints: NSLayoutConstraint!
    
    var chatMessageViewModel : ChatMessageViewModel = ChatMessageViewModel()
    fileprivate let cellId = "id123"
    
    //MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatMessageViewModel.attemptToAssembleGroupedMessages()
        //Set up tableview
        tableView.register(ChatMessageWithAttachmentCell.self, forCellReuseIdentifier: ChatMessageWithAttachmentCell.reuseIdentifier)
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        //Register Notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.tableView.scrollToBottomRow()
        }
    }
    @objc func handleKeyboardNotification(notification : Notification) {
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            
            let isShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomContraints.constant = isShowing ? keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completion) in
                self.tableView.scrollToBottomRow()
            })
        }
    }
    
    @IBAction func sendButtonOnClick(_ sender: Any) {
        guard let text = inputTextField.text else { return }
        if text.trim().count == 0 {
            return
        }
        let chatMessage = ChatMessage(text: text.trim(), isIncoming: false, date: Date())
        chatMessageViewModel.messagesFromServer.append(chatMessage)
        chatMessageViewModel.attemptToAssembleGroupedMessages()
        
        let sectionCount = chatMessageViewModel.chatMessages.count
        let itemCountInSection = chatMessageViewModel.chatMessages[sectionCount - 1].count
        let indexPath = IndexPath(row:  itemCountInSection - 1 , section: sectionCount - 1)

        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToBottomRow()
        inputTextField.text = ""
    }
    
}

//MARK: - UITableViewDataSource's medthods
extension ChatMessageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessageViewModel.chatMessages.count
    }
        
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
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
        if let firstMessageInSection = chatMessageViewModel.chatMessages[section].first {
            
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
        return 50 * kWidthRatio
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessageViewModel.chatMessages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
//        let chatMessage = chatMessages[indexPath.row]
        let chatMessage = chatMessageViewModel.chatMessages[indexPath.section][indexPath.row]
        let celltype = chatMessage.type
        switch celltype {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.reuseIdentifier, for: indexPath) as! ChatMessageCell
            cell.chatMessage = chatMessage
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageWithAttachmentCell.reuseIdentifier, for: indexPath) as! ChatMessageWithAttachmentCell
            cell.chatMessage = chatMessage
            cell.selectionStyle = .none
            return cell
        }
        
    }

}


//MARK: - UITableViewDelegate's medthods
extension ChatMessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
}
