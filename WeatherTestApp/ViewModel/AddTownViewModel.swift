//
//  AddTownViewModel.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 10/8/2022.
//

import Foundation
import WeatherAPIComponent
import CoreLocation
import Combine


class AddTownViewModel{
    
    lazy var locationManager = LocationManager()
    @Published var isNewTownAdded:Bool?
    private var coord:CLLocationCoordinate2D?
    
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
    func fetchWeather(lat: Double, lon: Double,units: String = K.QueryParams.Units.metric, exclude: String = K.QueryParams.Exclude.minutely, completion : @escaping (Bool) -> Void) {
        
        WeatherService.sharedInstance.provideApiKey("ace736a35120fd7d2b60a027ccbfdb1a")
        WeatherService.sharedInstance.getWeather(lat: lat, lon: lon,units: units, exclude: exclude) {[weak self] resp in
            switch resp {
            case .success(let response):
                print(response)
                DispatchQueue.global(qos: .background).async {
                    //save town info locally
                    DataBaseHelper.sharedInstance.addTown(with:response)
                    self?.isNewTownAdded = true
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
                let town = DataBaseHelper.sharedInstance.fetchTown(WithCoord: coord)
                if town == nil {
                    self?.fetchWeather(lat: coord.latitude, lon: coord.longitude){ succ in
                        completion(succ)
                    }
                }else{
                    // Town alreday added
                    completion(false)
                }
                
            }else{
                completion(false)
            }
        }
    }
}

// MARK: LocationManagerDelegate
extension AddTownViewModel: LocationManagerDelegate {
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func locationDidUpdate(_ service: LocationManager, location: CLLocation) {
        guard coord == nil else {
            return
        }
         coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.updateLocation(location : coord!){ [weak self] succ in
            if !succ {
                self?.isNewTownAdded = false
            }
        }
    }
    
    func locationDidFail(withError error: Error) {
        // Handle ERROR
    }
    
    func updateLocation(location:CLLocationCoordinate2D,completion:@escaping(Bool)->Void){
        let town = DataBaseHelper.sharedInstance.fetchTown(WithCoord: location)
        if town == nil {
            self.fetchWeather(lat: location.latitude, lon: location.longitude){ succ in
                completion(succ)
            }
        }else{
            // location alreday added
            completion(false)
        }
    }
}
