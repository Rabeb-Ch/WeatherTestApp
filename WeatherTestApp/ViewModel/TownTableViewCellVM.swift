//
//  TownTableViewCellVM.swift
//  WeatherTestApp
//
//  Created by Rabeb Chelbi on 10/8/2022.
//

import Foundation
import UIKit

struct TownTableViewCellVM {
    var townName:String?
    var accessoryImageName:String
    var withDelete:Bool = false
    
    init(_ name:String?,withDelete:Bool){
        self.townName = name ?? ""
        let isLocationCell = self.townName == K.Titles.currentLocation
        self.accessoryImageName =  isLocationCell ? K.Images.location : withDelete ? K.Images.trash : K.Images.plus
        self.withDelete = withDelete
    }
    
}
