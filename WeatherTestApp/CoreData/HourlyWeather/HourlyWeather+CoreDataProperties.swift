//
//  HourlyWeather+CoreDataProperties.swift
//  
//
//  Created by Rabeb Chelbi on 9/8/2022.
//
//

import Foundation
import CoreData


extension HourlyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyWeather> {
        return NSFetchRequest<HourlyWeather>(entityName: "HourlyWeather")
    }

    @NSManaged public var dt: String?
    @NSManaged public var temperature: Double
    @NSManaged public var icon: String?

}
