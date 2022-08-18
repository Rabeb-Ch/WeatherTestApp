//
//  K.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 17/08/2022.
//

import UIKit

struct K {
    
    // MARK: - Identifiers
    struct Identifiers {
        static let hourlyCollectionCellIdentifier = "HourlyCollectionViewCell"
        static let townTableViewCell = "TownTableViewCell"
        static let headerTableViewCell = "HeaderTableViewCell"
        static let weatherTableViewCell = "WeatherTableViewCell"
        static let hourlyTableViewCell = "HourlyTableViewCell"
        static let townListViewController = "TownListViewController"
        
    }
    
    // MARK: - Segues
    struct Segue {
        static let weatherViewController = "WeatherViewController"
    }
    
    // MARK: - Titles
    struct Titles {
        static let alertTitle = "Weather App"
        static let okBtnTitle = "OK"
        static let currentLocation = "Current location"
        
    }
    
    // MARK: - Images
    struct Images {
        static let location = "location.fill"
        static let trash = "trash"
        static let plus = "plus.circle"
        static let chevronBackward = "chevron.backward"
    }
    
    // MARK: QUERY params
    struct QueryParams {
        struct Units{
            static let metric = "metric"
            static let standard = "standard"
            static let imperial = "imperial"
        }
        struct Exclude{
            static let current = "current"
            static let minutely = "minutely"
            static let hourly = "hourly"
            static let daily = "daily"
            static let alerts = "alerts"
        }
    }
}
