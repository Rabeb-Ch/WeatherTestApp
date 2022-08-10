//
//  DataHelper.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 9/8/2022.
//

import Foundation
import CoreLocation

struct DataHelper {
    
    // TODO: change timeZone
    
    /**
     * Format the unixTimestamp to short time format "HH:mm"
     * - parameter stmp : the unixTimestamp to format
    */
    static func getShortTime(from stmp : Double) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: stmp)
        return dateFormatter.string(from: date)
    }

    /**
     * Format the unixTimestamp to day format like: Monday"
     * - parameter stmp : the unixTimestamp to format
    */
    static func getDay(from stmp : Double) -> String{
        let date = Date(timeIntervalSince1970: stmp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    
    
    static func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
}

