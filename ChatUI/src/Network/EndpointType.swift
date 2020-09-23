//
//  EndpointType.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/23/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//

import Alamofire
import MobileCoreServices

protocol EndpointType {
    var baseURL: URL { get }
    var method : HTTPMethod { get }
    var path: String { get }
    var header: HTTPHeaders { get }
}
