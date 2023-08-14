//
//  ReusableViewProtocol.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import UIKit

protocol ReusableViewProtocol {
    // 타입 연산 프로퍼티 사용
    static var identifier: String { get }
}
// protocol 없이 아래 extension만 사용하는 것도 가능하지만,
// identifier의 역할이 같으므로 구조를 잡기 위해 프로토콜 사용

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
