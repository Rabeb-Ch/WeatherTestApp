//
//  Town+CoreDataProperties.swift
//  
//
//  Created by Rabeb Chelbi on 10/8/2022.
//
//

import Foundation
import CoreData


extension Town {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Town> {
        return NSFetchRequest<Town>(entityName: "Town")
    }

    @NSManaged public var name: String?
    @NSManaged public var current: CurrentWeather?

}
