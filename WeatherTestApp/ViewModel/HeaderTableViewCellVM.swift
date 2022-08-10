//
//  HeaderTableViewCellVM.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 10/8/2022.
//

import Foundation
import WeatherAPIComponent

struct HeaderTableViewCellVM {
    var timeZone:String
    var desc:String
    var temperature:String
    init(currentWeather:CurrentWeather?){
        timeZone = currentWeather?.timezone ?? ""
        desc = currentWeather?.desc ?? currentWeather?.main ?? ""
        temperature = String(format: "%0.0f°",currentWeather?.temperature ?? 0.0)
    }
    
}
