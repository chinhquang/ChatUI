//
//  ChatMessageCell.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    static let reuseIdentifier = "ChatMessageCell"

    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12 * kWidthRatio
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16 * kWidthRatio),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32 * kWidthRatio),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250 * kWidthRatio),
           
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16 * kWidthRatio),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16 * kWidthRatio),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16 * kWidthRatio),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16 * kWidthRatio),
            ]
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32 * kWidthRatio)
        leadingConstraint.isActive = false
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32 * kWidthRatio)
        trailingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class ChatMessageWithAttachmentCell: UITableViewCell {
    static let reuseIdentifier = "ChatMessageWithAttachmentCell"
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    let attachImageView : UIImageView = {
        let imV = UIImageView()
        imV.contentMode = .scaleAspectFill
        imV.image = #imageLiteral(resourceName: "image_placeholder")
        imV.isUserInteractionEnabled = true
        imV.layer.masksToBounds = true
        return imV
    }()
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var imageTapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer()
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            setNeedsLayout()
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                messageLabel.textAlignment = .left
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                messageLabel.textAlignment = .right

            }
            
            layoutIfNeeded()
            switch chatMessage.type{
                
            case .text:
                removePlayButton()
                return
            case .image(imageURL: let imageURL):
                attachImageView.setImage(imgURL: imageURL, placeHolderImage: #imageLiteral(resourceName: "image_placeholder"))
                removePlayButton()
            case .video(videoURL: let videoURL):
                guard let url = URL(string: videoURL) else {
                    attachImageView.image = #imageLiteral(resourceName: "image_placeholder")
                    return
                }
                getThumbnailImageFromVideoUrl(url: url) { [weak self](thumbNailImage) in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        self.attachImageView.image = thumbNailImage
                    }
                    
                    
                }
                addPlayImageView()
                layoutIfNeeded()
                return
            
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 12 * kWidthRatio
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        
        attachImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        addSubview(attachImageView)
        
        // lets set up some constraints for our label and attach image
        let constraints = [
            
            attachImageView.widthAnchor.constraint(equalToConstant:  240 * kWidthRatio),
            attachImageView.heightAnchor.constraint(equalToConstant:  240 * kWidthRatio),
            attachImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32 * kWidthRatio),
//            attachImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16 * kWidthRatio),

            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16 * kWidthRatio),
            messageLabel.bottomAnchor.constraint(equalTo: attachImageView.topAnchor, constant: -16 * kWidthRatio),
            messageLabel.widthAnchor.constraint(equalToConstant:  240 * kWidthRatio),
            messageLabel.trailingAnchor.constraint(equalTo: attachImageView.trailingAnchor, constant: 0),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16 * kWidthRatio),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: attachImageView.leadingAnchor, constant: -16 * kWidthRatio),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: attachImageView.bottomAnchor, constant: 16 * kWidthRatio),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: attachImageView.trailingAnchor, constant: 16 * kWidthRatio),
            ]
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = attachImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32 * kWidthRatio)
        leadingConstraint.isActive = false
        
        trailingConstraint = attachImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32 * kWidthRatio)
        trailingConstraint.isActive = true
        
        
        imageTapGestureRecognizer.addTarget(self, action: #selector(handleAttachmentTap(_:)))
        imageTapGestureRecognizer.numberOfTapsRequired = 1
        attachImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    lazy var playImageView : UIImageView = {
        let imV = UIImageView(image: #imageLiteral(resourceName: "playButton"))
        imV.contentMode = .scaleAspectFit
        return imV
    }()
    
    func addPlayImageView() {
        self.addSubview(playImageView)
        playImageView.frame = CGRect(x: 0, y: 0, width: 100 * kWidthRatio, height: 100 * kWidthRatio)
        playImageView.center = attachImageView.center
        let playGesture = UITapGestureRecognizer()
        playGesture.addTarget(self, action: #selector(handleAttachmentTap(_:)))
        playGesture.numberOfTapsRequired = 1
        playImageView.addGestureRecognizer(playGesture)
    }
    func removePlayButton (){
        playImageView.removeFromSuperview()
    }
    @objc func handleAttachmentTap (_ sender: UITapGestureRecognizer){
        let fileViewerController = AttachmentViewerController(imageViews: attachImageView, messageType: chatMessage.type)
        fileViewerController.showGalleryImageViewer(displacedView: attachImageView, fromViewController: kCurrentViewController!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}











