//
//  AsyncViewController.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        firstImageView.backgroundColor = .lightGray
        print("1")
        
        DispatchQueue.main.async {
            self.firstImageView.layer.cornerRadius = self.firstImageView.frame.width / 2
            print("2")
        }
        print("3")
    }

    // sync, async, serial, concurrent
    // UI Freezing
    
    @IBAction func tappedButton(_ sender: UIButton) {
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        
        DispatchQueue.global().async {
            // 오래 걸리는 작업 글로벌에 부탁
            let data = try! Data(contentsOf: url)
            
            DispatchQueue.main.async { // UI 관련 작업은 메인쓰레드에서 담당
                self.firstImageView.image = UIImage(data: data)
            }
        }
    }
}
