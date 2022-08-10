//
//  CurrentWeather+CoreDataProperties.swift
//  
//
//  Created by Rabeb Chelbi on 10/8/2022.
//
//

import Foundation
import CoreData


extension CurrentWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeather> {
        return NSFetchRequest<CurrentWeather>(entityName: "CurrentWeather")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var timezone: String?
    @NSManaged public var dt: String?
    @NSManaged public var temperature: Double
    @NSManaged public var main: String?
    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var daily: NSOrderedSet?
    @NSManaged public var hourly: NSOrderedSet?

}

// MARK: Generated accessors for daily
extension CurrentWeather {

    @objc(insertObject:inDailyAtIndex:)
    @NSManaged public func insertIntoDaily(_ value: DailyWeather, at idx: Int)

    @objc(removeObjectFromDailyAtIndex:)
    @NSManaged public func removeFromDaily(at idx: Int)

    @objc(insertDaily:atIndexes:)
    @NSManaged public func insertIntoDaily(_ values: [DailyWeather], at indexes: NSIndexSet)

    @objc(removeDailyAtIndexes:)
    @NSManaged public func removeFromDaily(at indexes: NSIndexSet)

    @objc(replaceObjectInDailyAtIndex:withObject:)
    @NSManaged public func replaceDaily(at idx: Int, with value: DailyWeather)

    @objc(replaceDailyAtIndexes:withDaily:)
    @NSManaged public func replaceDaily(at indexes: NSIndexSet, with values: [DailyWeather])

    @objc(addDailyObject:)
    @NSManaged public func addToDaily(_ value: DailyWeather)

    @objc(removeDailyObject:)
    @NSManaged public func removeFromDaily(_ value: DailyWeather)

    @objc(addDaily:)
    @NSManaged public func addToDaily(_ values: NSOrderedSet)

    @objc(removeDaily:)
    @NSManaged public func removeFromDaily(_ values: NSOrderedSet)

}

// MARK: Generated accessors for hourly
extension CurrentWeather {

    @objc(insertObject:inHourlyAtIndex:)
    @NSManaged public func insertIntoHourly(_ value: HourlyWeather, at idx: Int)

    @objc(removeObjectFromHourlyAtIndex:)
    @NSManaged public func removeFromHourly(at idx: Int)

    @objc(insertHourly:atIndexes:)
    @NSManaged public func insertIntoHourly(_ values: [HourlyWeather], at indexes: NSIndexSet)

    @objc(removeHourlyAtIndexes:)
    @NSManaged public func removeFromHourly(at indexes: NSIndexSet)

    @objc(replaceObjectInHourlyAtIndex:withObject:)
    @NSManaged public func replaceHourly(at idx: Int, with value: HourlyWeather)

    @objc(replaceHourlyAtIndexes:withHourly:)
    @NSManaged public func replaceHourly(at indexes: NSIndexSet, with values: [HourlyWeather])

    @objc(addHourlyObject:)
    @NSManaged public func addToHourly(_ value: HourlyWeather)

    @objc(removeHourlyObject:)
    @NSManaged public func removeFromHourly(_ value: HourlyWeather)

    @objc(addHourly:)
    @NSManaged public func addToHourly(_ values: NSOrderedSet)

    @objc(removeHourly:)
    @NSManaged public func removeFromHourly(_ values: NSOrderedSet)

}
