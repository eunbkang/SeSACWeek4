//
//  URL+Extension.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import Foundation

extension URL {
    static let baseUrl = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointUrl(_ endPoint: String) -> String {
        return baseUrl + endPoint
    }
}
