//
//  WeatherViewController.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
    }
    

    func callRequest() {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.openWeather)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15 // kelvin -> 섭씨
                let humidity = json["main"]["humidity"].intValue
                
                let id = json["weather"][0]["id"].intValue // 배열이므로 인덱스 적어주어야 함
                
                switch id {
                case 800: print("매우 맑음")
                case 801...899:
                    self.weatherLabel.text = "구름 낀 날씨입니다."
                    self.view.backgroundColor = .lightGray
                default: print("더이상의 자세한 설명 셍략..")
                }
                
                self.tempLabel.text = "\(temp)도 입니다."
                self.humidityLabel.text = "\(humidity)% 입니다."
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
