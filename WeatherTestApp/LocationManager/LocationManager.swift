//
//  LocationManager.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 11/8/2022.
//
import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func locationDidUpdate(_ service: LocationManager, location: CLLocation)
    func locationDidFail(withError error: Error)
}

class LocationManager: NSObject {
    
    var delegate: LocationManagerDelegate?
    fileprivate let locationManager = CLLocationManager()
    fileprivate var isLocationAvailable: Bool {
        switch locationManager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            return false
        default:
            return true
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation(){
        if isLocationAvailable {
            self.locationManager.startUpdatingLocation()
        }else{
            //request
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManager Delegate
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        if let location = locations.first {
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationDidFail(withError: error)
        print("Error finding location: \(error.localizedDescription)")
    }
}
