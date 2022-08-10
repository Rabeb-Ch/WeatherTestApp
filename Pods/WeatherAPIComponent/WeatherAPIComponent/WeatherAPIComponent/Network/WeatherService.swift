//
//  WeatherService.swift
//  WeatherAPIComponent
//
//  Created by Rabeb Chelbi on 7/8/2022.
//

import Foundation

public class WeatherService {
    
    public static let sharedInstance = WeatherService()
    
    // MARK: - Constants
    private static let apiEndpoint: String = "https://api.openweathermap.org/data/2.5/onecall?"
    private static let queryLatitudeEndpoint: String = "lat="
    private static let queryLongitudeEndpoint: String = "&lon="
    private static let queryUnitsEndpoint: String = "&units="
    private static let queryExcludeEndpoint: String = "&exclude="
    private static let appIDEndpoint: String = "&appid="
    
    // MARK: - Provide API_KEY
    /** will be replaced, using the provideApiKey func, with your unique API key (you can always find it on your account page under the "API key" tab)*/
    private lazy var appID = "{API_key}"
    public func provideApiKey(_ apiKey : String){
        self.appID = apiKey
    }
    
    // MARK: - Fetch Weather informations
    /**
     * Get Weather informations from One Call API 
     * - parameter lat (required)  :  Geographical coordinates of the location (latitude)
     * - parameter lon (required) : Geographical coordinates of the location (longitude)
     * - parameter units (optional) : Units of measurement.
     *      Available values: standard, metric and imperial.
     *      Temperature. Units - default: kelvin, metric: Celsius, imperial: Fahrenheit
     *      If you do not use the units parameter, standard units will be applied by default.
     * - parameter exclude (optional) :  excludes some parts of the weather data from the API response. It should be a comma-delimited list (without spaces).
     *      Available values: current,minutely,hourly,daily,alerts
     * - parameter completion: returns a WeatherResponse object  if success, else returns a NetworkError
     */
    public func getWeather(lat:Double,lon:Double,units:String = "",exclude:String = "", completion : @escaping ((Result<WeatherResponse, NetworkError>) -> Void)){
        
        // Create the url String
        var urlString = WeatherService.apiEndpoint+WeatherService.queryLatitudeEndpoint+"\(lat)"+WeatherService.queryLongitudeEndpoint+"\(lon)"
        
        //add optional params if exists
        if !units.isEmpty {
            urlString += WeatherService.queryUnitsEndpoint+units
        }
        if !exclude.isEmpty {
            urlString += WeatherService.queryExcludeEndpoint+exclude
        }
        //add appID
        urlString += WeatherService.appIDEndpoint+appID
        // Create the URL from the urlString
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        NetworkManager().fetchAPI(fromUrl: url, forType: WeatherResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

