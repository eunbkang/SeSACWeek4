//
//  VideoTableViewCell.swift
//  SeSACWeek4
//
//  Created by Eunbee Kang on 2023/08/09.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
//    static let identifier = "VideoTableViewCell" // UITableViewCell에 ReusableViewProtocol 채택하여 불필요
    
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.numberOfLines = 2
    }
}
