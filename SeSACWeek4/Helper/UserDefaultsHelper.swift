//
//  UserDefaultsHelper.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import Foundation

class UserDefaultsHelper {
    static let standard = UserDefaultsHelper() // 싱글톤 패턴
    
    private init() { } // 접근 제어자(다음주)
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String { // 컴파일 최적화
        case nickname, age
    }
    
    // 프로퍼티가 많아지는 경우 코드 라인이 너무 길어짐. 추후 배울 property wrapper로 개선 가능
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
}
