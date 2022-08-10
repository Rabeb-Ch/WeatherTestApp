//
//  DailyWeather+CoreDataProperties.swift
//  
//
//  Created by Rabeb Chelbi on 9/8/2022.
//
//

import Foundation
import CoreData


extension DailyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyWeather> {
        return NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
    }

    @NSManaged public var dt: String?
    @NSManaged public var minTemperature: Double
    @NSManaged public var maxTemperature: Double
    @NSManaged public var icon: String?

}
