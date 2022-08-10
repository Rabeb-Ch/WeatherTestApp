//
//  WeatherResponse.swift
//  WeatherAPIComponent
//
//  Created by Rabeb Chelbi on 7/8/2022.
//

import Foundation

// MARK: - WeatherResponse
public struct WeatherResponse: Decodable {
    public let lat,lon: Double
    public let timezone: String
    public let current: Current
    public let hourly: [Current]
    public let daily: [Daily]
}

// MARK: - Current
public struct Current: Decodable {
    public let dt: Int
    public let temp: Double
    public let weather: [Weather]
}

// MARK: - Weather
public struct Weather: Decodable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}

// MARK: - Daily
public struct Daily: Decodable {
    public let dt: Int
    public let temp: Temp
    public let weather: [Weather]
}

// MARK: - Temp
public struct Temp: Decodable {
    public let day, min, max, night: Double
    public let eve, morn: Double
}


