//
//  WeatherTableViewCell.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import UIKit
import WeatherAPIComponent

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var weatherCellVM:WeatherTableViewCellVM?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWeatherCell(){
        dayLabel.text = weatherCellVM?.day
        lowTemperatureLabel.text = weatherCellVM?.minTemperature
        highTemperatureLabel.text = weatherCellVM?.maxTemperature
        icon.image = UIImage(named: weatherCellVM?.icon ?? "")
    }
    
}
