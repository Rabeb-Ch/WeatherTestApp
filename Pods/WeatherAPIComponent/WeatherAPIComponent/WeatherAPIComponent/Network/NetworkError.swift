//
//  NetworkError.swift
//  WeatherAPIComponent
//
//  Created by Rabeb Chelbi on 7/8/2022.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case networkRequestFailed
    case jsonSerializationFailed
    case jsonDecodingFailed
}
