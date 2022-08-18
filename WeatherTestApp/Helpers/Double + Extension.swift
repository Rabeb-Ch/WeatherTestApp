//
//  Double + Extension.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 17/08/2022.
//

import Foundation

extension Double {
    func getFormattedValue() -> String {
        return String(format: "%.3f", self)
    }
}
