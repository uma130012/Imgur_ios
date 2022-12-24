//
//  ApiConstants.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.

import Foundation
struct API {
    
    
    // MARK:- Base URL
    static let baseUrl = BaseUrl.dev.value
    
    // MARK:-  Routes
    static let gallary = baseUrl + "/3/gallery/search/top/week/0"
}
