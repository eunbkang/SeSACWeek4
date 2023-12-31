//
//  TranslationViewController.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class TranslationViewController: UIViewController {

    @IBOutlet var originTextView: UITextView!
    @IBOutlet var translatedTextView: UITextView!
    
    @IBOutlet var requestButton: UIButton!
    
    // 접근 제어자때문에 인스턴스 생성 불가
//    let helper = UserDefaultsHelper()
    
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.naver,
        "X-Naver-Client-Secret": APIKey.naverSecret
    ]
    
    var detectedLanguage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("고래밥", forKey: "nickname")
        UserDefaults.standard.set(33, forKey: "age")
        UserDefaultsHelper.standard.nickname = "칙촉"
        
        UserDefaults.standard.string(forKey: "nickname")
        UserDefaults.standard.integer(forKey: "age")
        originTextView.text = UserDefaultsHelper.standard.nickname
        
        originTextView.text = ""
        translatedTextView.text = ""
        translatedTextView.isEditable = false
    }
    
    @IBAction func tappedRequestButton(_ sender: UIButton) {
//        makeDetectLangRequest()
        TranslateAPIManager.shared.callRequest(text: originTextView.text) { resultText in
            self.translatedTextView.text = resultText
        }
    }
    
    func makeDetectLangRequest() {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let parameters: Parameters = [
            "query": originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                self.detectedLanguage = json["langCode"].stringValue
                
                self.makeTranslateRequest()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func makeTranslateRequest() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        guard let source = detectedLanguage else {
            print("no langCode")
            return
        }
        
        let parameters: Parameters = [
            "source": source,
            "target": "en",
            "text": originTextView.text ?? ""
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let data = json["message"]["result"]["translatedText"].stringValue
                self.translatedTextView.text = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
