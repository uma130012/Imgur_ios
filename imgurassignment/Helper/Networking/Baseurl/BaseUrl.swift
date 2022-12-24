//
//  BaseUrl.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.

import Foundation
enum BaseUrl: String {

    case dev
    case prod

    var value: String {
        switch self {
        case .dev: return "https://api.imgur.com" // Dev Server
        case .prod: return "https://api.imgur.com" //Live Server
        }
    }
}
