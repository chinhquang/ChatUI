//
//  UIImageView_extensions.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImageView {
    func setImage(imgURL : String, placeHolderImage : UIImage? = nil){
        self.sd_setImage(with: URL(string: imgURL), placeholderImage: placeHolderImage)
    }
    func setImage(from imgURL : String, with placeHolderImage : UIImage? = nil){
        
        self.sd_setImage(with: URL(string: imgURL), placeholderImage: placeHolderImage, options: .refreshCached)
    }
}
