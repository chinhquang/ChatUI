//  NSLayoutHelper.swift
//  Layout Helper
//
//  Created by Kuldeep Tanwar on 4/15/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
//  Updated by chinh.tq
import UIKit
@IBDesignable class NSLayoutHelper : NSLayoutConstraint {
    @IBInspectable var iPhone4s: CGFloat = 0.0 {
        didSet { deviceConstant(.i3_5Inch,value:iPhone4s) }
    }
    @IBInspectable var iPhoneSE: CGFloat = 0.0 {
        didSet { deviceConstant(.i4Inch,value:iPhoneSE) }
    }
    @IBInspectable var iPhone8: CGFloat = 0.0 {
        didSet { deviceConstant(.i4_7Inch,value:iPhone8) }
    }
    @IBInspectable var iPhone8Plus: CGFloat = 0.0 {
        didSet { deviceConstant(.i5_5Inch,value:iPhone8Plus) }
    }
    @IBInspectable var iPhoneXS: CGFloat = 0.0 {
        didSet { deviceConstant(.i5_8Inch,value:iPhoneXS) }
    }
    
    @IBInspectable var iPhoneXR: CGFloat = 0.0 {
        didSet { deviceConstant(.i6_1Inch,value:iPhoneXR) }
    }
    
    @IBInspectable var iPhoneXMax: CGFloat = 0.0 {
        didSet { deviceConstant(.i6_5Inch,value:iPhoneXMax) }
    }
//    // chinh.tq - XS max = 11 pro max
//    @IBInspectable var iPhone11ProMax: CGFloat = 0.0 {
//        didSet { deviceConstant(.i6_5Inch,value:iPhone11ProMax) }
//    }
//    //chinh.tq - Xs = 11 pro = X
//    @IBInspectable var iPhone11Pro: CGFloat = 0.0 {
//        didSet { deviceConstant(.i5_8Inch,value:iPhone11Pro) }
//    }
//    // chinh.tq - XR = 11
//    @IBInspectable var iPhone11: CGFloat = 0.0 {
//        didSet { deviceConstant(.i6_1Inch,value:iPhone11) }
//    }
    @IBInspectable var iPadMini: CGFloat = 0.0 {
        didSet { deviceConstant(.i7_9Inch,value:iPadMini) }
    }
    @IBInspectable var iPadPro9_7: CGFloat = 0.0 {
        didSet { deviceConstant(.i9_7Inch,value:iPadPro9_7) }
    }
    @IBInspectable var iPadPro10_5: CGFloat = 0.0 {
        didSet { deviceConstant(.i10_5Inch,value:iPadPro10_5) }
    }
    @IBInspectable var iPadPro12_9: CGFloat = 0.0 {
        didSet { deviceConstant(.i12_9Inch,value:iPadPro12_9) }
    }
    // Helpers
    open func deviceConstant(_ device:UIDeviceSize,value:CGFloat) {
        if deviceSize == device {
            constant = value
        }
    }
}

