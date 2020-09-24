//
//  Constants.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

//This file is used to define hard string and constants

import UIKit

//MARK: - Screen Titles
let kListConversationScreenTitle = "LittleLives"
let kListMessageScreenTitle = "LittleLives Demo"

//MARK: - Device ratio
// Size base : iPhone 8, iPhone 6 with width 375
let kWidthRatio = 375 / UIScreen.main.bounds.width

//MARK: - Mock data file name
let kMockingDataFileName = "MockData"

//MARK: - Callback typealias
public typealias IntHandler = (Int) -> (Void)
public typealias DateHandler = (Date?) -> (Void)
public typealias ImageHandler = (UIImage?) -> (Void)
public typealias BoolHandler = (Bool) -> (Void)
public typealias StringHandler = (String?) -> (Void)
public typealias VoidHandler = () -> ()


