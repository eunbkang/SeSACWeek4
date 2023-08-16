//
//  VideoViewController.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher

class VideoViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var videoTableView: UITableView!
    
    var videoList: [Document] = []
    var page = 1
    var isEnd = false // 현재 페이지가 마지막 페이지인지 점검하는 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.prefetchDataSource = self
        videoTableView.rowHeight = 100

        searchBar.delegate = self
    }
    
    func callRequest(query: String, page: Int) {
        print(#function)
        
        KakaoAPIManager.shared.callRequest(type: .video, query: query) { result in
            self.videoList.append(contentsOf: result.documents)
            self.videoTableView.reloadData()
        }
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                // 상태코드 받아보기
//                let statusCode = response.response?.statusCode ?? 500 // 처음 학습하는거니까 일단 기본값은 이렇게
//
//                // 성공 시에만 videoList 담기
//                if statusCode == 200 {
//
//                    self.isEnd = json["meta"]["is_end"].boolValue
//
//
//                    let videos = json["documents"].arrayValue
//
//                    for item in videos {
//                        let author = item["author"].stringValue
//                        let date = item["datetime"].stringValue
//                        let playtime = item["play_time"].intValue
//                        let thumbnail = item["thumbnail"].stringValue
//                        let title = item["title"].stringValue
//                        let link = item["url"].stringValue
//
//                        let video = Video(author: author, date: date, playtime: playtime, thumbnail: thumbnail, title: title, link: link)
//
//                        self.videoList.append(video)
//                    }
//                    self.videoTableView.reloadData()
//
//                // 실제 운영하는 서비스의 경우 에러코드마다 별개로 대응해주는 것이 좋음
//                } else {
//                    print("문제가 발생했어요. 잠시 후 다시 시도해주세요.")
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
//    func makeViewFromJson(json: JSON) {
//        self.isEnd = json["meta"]["is_end"].boolValue
//
//        let videos = json["documents"].arrayValue
//
//        for item in videos {
//            let author = item["author"].stringValue
//            let date = item["datetime"].stringValue
//            let playtime = item["play_time"].intValue
//            let thumbnail = item["thumbnail"].stringValue
//            let title = item["title"].stringValue
//            let link = item["url"].stringValue
//
//            let video = Video(author: author, date: date, playtime: playtime, thumbnail: thumbnail, title: title, link: link)
//
//            self.videoList.append(video)
//        }
//        self.videoTableView.reloadData()
//    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        
        let video = videoList[indexPath.row]
        
        cell.titleLabel.text = video.title
        cell.infoLabel.text = video.info
        
        if let url = URL(string: video.thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    // UITableViewDataSourcePrefetching: iOS10 이상 사용 가능한 프로토콜. cellForRowAt 메서드가 호출되기 전에 미리 호출됨
    
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는 기능
    // videoList 개수와 indexPath.row 위치를 비교해 마지막 스크롤 시점을 확인 -> 네트워크 요청 시도
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let query = searchBar.text else { return }
        
        for indexPath in indexPaths {
            // 1) 마지막 셀이 보여질 때, 2) 카카오의 경우 page가 15보다 작을 때, 3) 마지막 페이지가 아닐 때
            if videoList.count - 1 == indexPath.row && page < 15 && !isEnd {
                page += 1 // 다음 페이지를
                callRequest(query: query, page: page) // 불러옴
            }
        }
    }
    
    // 취소 기능: 직접 취소하는 기능을 구현해주어야 함
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("====취소: \(indexPaths)")
    }
}

extension VideoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        page = 1
        videoList.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
    }
}
