//
//  KakaoAPIManager.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import Foundation
import Alamofire

class KakaoAPIManager {
    
    static let shared = KakaoAPIManager()
    private init() { }
    
    let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoRest)"]
    
    func callRequest(type: Endpoint, query: String, completionHandler: @escaping (KakaoVideoResult) -> ()) {
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = type.requestUrl + searchText
        
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: KakaoVideoResult.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)
                
            case .failure(let error):
                print("API 에러:", error)
            }
        }
    }
}
