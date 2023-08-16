//
//  TranslateAPIManaver.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import Foundation
import Alamofire
import SwiftyJSON

class TranslateAPIManager {
    static let shared = TranslateAPIManager()
    private init() { }
    
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.naver,
        "X-Naver-Client-Secret": APIKey.naverSecret
    ]
    
    // @escaping - 클로저 내 클로저 있는 상황에서 탈출하는 타이밍 잡기 위함
    func callRequest(text: String, resultString: @escaping (String) -> Void) {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let parameters: Parameters = [
            "source": "ko",
            "target": "en",
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                
                resultString(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
