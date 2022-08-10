//
//  WeatherTableViewCellVM.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 10/8/2022.
//

import Foundation
import WeatherAPIComponent

struct WeatherTableViewCellVM{
    
    var day:String
    var minTemperature,maxTemperature:String
    var icon:String
    
    init(_ daily:DailyWeather?){
        self.day = daily?.dt ?? ""
        self.minTemperature = String(format: "%0.0f°",daily?.minTemperature ?? 0.0)
        self.maxTemperature = String(format: "%0.0f°",daily?.maxTemperature ?? 0.0)
        self.icon =  daily?.icon ?? ""
    }
    
}
