//
//  DataBasehelper.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 8/8/2022.
//

import Foundation
import UIKit
import CoreData
import CoreLocation
import WeatherAPIComponent

class DataBaseHelper {
    
    static let sharedInstance = DataBaseHelper()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: TOWN
    func addTown(with weather : WeatherResponse){
        let town = Town(context: context)
        town.name = weather.timezone
        
        let current = self.addCurrentWeather(with: weather)
        town.current = current
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchTowns() -> [Town] {
        let fetchRequest = Town.fetchRequest()
        do {
            let response = try context.fetch(fetchRequest)
            
            if (response.count > 0){
                return response
            }
        } catch {
            print("Error fetching Towns")
        }
        
        return []
    }
    
    func fetchTown(WithCoord: CLLocationCoordinate2D) -> Town?{
        let fetchRequest = Town.fetchRequest()

        do {
            let response = try context.fetch(fetchRequest)
            let lat = WithCoord.latitude.getFormattedValue()
            let lon = WithCoord.longitude.getFormattedValue()
            
            let resp = response.filter {$0.current?.lat.getFormattedValue() ==  lat
                && $0.current?.lon.getFormattedValue() == lon
            }
            if (resp.count > 0){
                return resp.first!
            }
        } catch {
            print("Error fetching Towns")
        }
        return nil
    }
    func deleteTown(town : Town){
        context.delete(town)
        do {
            try context.save()
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: CurrentWeather
    func addCurrentWeather(with weather: WeatherResponse) -> CurrentWeather?{
        let current = CurrentWeather(context: context)
        current.lat = weather.lat
        current.lon = weather.lon
        current.timezone = weather.timezone
        current.dt = DataHelper.getShortTime(from: Double(weather.current.dt))
        current.temperature = weather.current.temp
        let _weather = weather.current.weather.first
        current.main = _weather?.main ?? ""
        current.desc = _weather?.description ?? ""
        current.icon = _weather?.icon ?? ""
        
        let hourlyForecasts = self.addHourlyWeather(with: weather.hourly)
        current.addToHourly(NSOrderedSet(array: hourlyForecasts))
        
        let dailyForecasts = self.addDailyWeather(with: weather.daily)
        current.addToDaily(NSOrderedSet(array: dailyForecasts))
        
        do {
            try context.save()
            return current
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return nil
    }
    
    // MARK: HourlyWeather
    func addHourlyWeather(with currentList: [Current]) -> [HourlyWeather]{
        var hourlyforecasts : [HourlyWeather] = []
        for current in currentList {
            let hourly = HourlyWeather(context: context)
            hourly.dt = DataHelper.getShortTime(from: Double(current.dt))
            hourly.temperature = current.temp
            let _weather = current.weather.first
            hourly.icon = _weather?.icon ?? ""
            hourlyforecasts.append(hourly)
        }
        return hourlyforecasts
    }
    
    // MARK: DailyWeather
    func addDailyWeather(with currentList: [Daily])->[DailyWeather]{
        var dailyforecasts : [DailyWeather] = []
        for current in currentList {
            let daily = DailyWeather(context: context)
            daily.dt = DataHelper.getDay(from: Double(current.dt))
            daily.minTemperature = current.temp.min
            daily.maxTemperature = current.temp.max
            let _weather = current.weather.first
            daily.icon = _weather?.icon ?? ""
            dailyforecasts.append(daily)
        }
        return dailyforecasts
    }
}
