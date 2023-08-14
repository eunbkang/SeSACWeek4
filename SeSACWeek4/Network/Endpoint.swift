//
//  Endpoint.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    case video
    
    var requestUrl: String {
        switch self {
        case .blog: return URL.makeEndPointUrl("blog?query=")
        case .cafe: return URL.makeEndPointUrl("cafe?query=")
        case .video: return URL.makeEndPointUrl("vclip?query=")
        }
    }
}
