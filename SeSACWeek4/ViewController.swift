//
//  ViewController.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Movie {
    var title: String
    var releaseDate: String
}

class ViewController: UIViewController {

    @IBOutlet var movieTableView: UITableView!
    @IBOutlet var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet var searchBar: UISearchBar!
    
    var movieList: [Movie] = []
    
    // codable
    var result: BoxOffice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = 60
        
        searchBar.delegate = self
        
        loadingIndicatorView.isHidden = true
    }

    func callRequest(date: String) {
        
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.isHidden = false
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: BoxOffice.self) { response in
                print(response.value)
                
                self.result = response.value

                self.loadingIndicatorView.stopAnimating()
                self.loadingIndicatorView.isHidden = true
                self.movieTableView.reloadData()
            }
        
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
//                    let title = item["movieNm"].stringValue
//                    let releaseDate = item["openDt"].stringValue
//
//                    let movie = Movie(title: title, releaseDate: releaseDate)
//
//                    self.movieList.append(movie)
//                }
//
//                self.loadingIndicatorView.stopAnimating()
//                self.loadingIndicatorView.isHidden = true
//                self.movieTableView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result else { return 0 }
        return result.boxOfficeResult.dailyBoxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")!
        
//        let movie = movieList[indexPath.row]
        let movie = result?.boxOfficeResult.dailyBoxOfficeList[indexPath.row]
        
        cell.textLabel?.text = movie?.movieNm
        cell.detailTextLabel?.text = movie?.openDt
        
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieList.removeAll()
        
        // 20220101 > 1. 8글자 2. 20233333 올바른 날짜 3. 날짜 범주
        guard let query = searchBar.text else { return }
        
        callRequest(date: query)
    }
}
