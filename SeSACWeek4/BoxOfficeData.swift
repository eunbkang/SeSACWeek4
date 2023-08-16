//
//  BoxOfficeData.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/14.
//

import Foundation

// MARK: - BoxOffice
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    let boxofficeType: String
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let audiAcc, openDt, audiInten, audiCnt: String
    let salesChange, rnum, rankInten, rank: String
    let movieNm, salesShare, salesAcc: String
    let rankOldAndNew: RankOldAndNew
    let salesInten, scrnCnt, salesAmt, movieCD: String
    let audiChange, showCnt: String

    enum CodingKeys: String, CodingKey {
        case audiAcc, openDt, audiInten, audiCnt, salesChange, rnum, rankInten, rank, movieNm, salesShare, salesAcc, rankOldAndNew, salesInten, scrnCnt, salesAmt
        case movieCD = "movieCd"
        case audiChange, showCnt
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
}
