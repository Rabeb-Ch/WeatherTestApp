//
//  HourlyCollectionViewCell.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ hour : HourlyWeather?){
        timeLabel.text = hour?.dt
        iconImageView.image = UIImage(named: hour?.icon ?? "")
        temperatureLabel.text = String(format: "%0.0f°",hour?.temperature ?? 0.0)
    }

}
