//
//  AddTownViewModel.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 10/8/2022.
//

import Foundation
import WeatherAPIComponent

class AddTownViewModel{
    
    func getTownsList() -> [String]{
        let timeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
        let allCities = timeZoneIdentifiers.compactMap { identifier in
            return identifier.split(separator: "/").last.map { String($0) }
        }
        return allCities
    }
    func searchTownWith(prefix:String) ->[String]{
        getTownsList().filter { $0.contains(prefix)}
    }
    func fetchWeather(lat: Double, lon: Double,units: String = "metric", exclude: String = "minutely", completion : @escaping (Bool) -> Void) {
        
        WeatherService.sharedInstance.provideApiKey("ace736a35120fd7d2b60a027ccbfdb1a")
        WeatherService.sharedInstance.getWeather(lat: lat, lon: lon,units: units, exclude: exclude) { resp in
            switch resp {
            case .success(let response):
                print(response)
                DispatchQueue.global(qos: .background).async {
                    //save town info locally
                    DataBaseHelper.sharedInstance.addTown(with:response)
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func addTown(_ town : String,completion:@escaping(Bool)->Void){
        DataHelper.getCoordinate(addressString:town) { [weak self] (coord , error) in
            if error == nil {
                self?.fetchWeather(lat: coord.latitude, lon: coord.longitude){ succ in
                    completion(succ)
                }
            }else{
                completion(false)
            }
        }
    }
}
