//
//  RoundedView.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
class RoundedView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    func setUpView (){
        layoutIfNeeded()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height/2
    }
}
