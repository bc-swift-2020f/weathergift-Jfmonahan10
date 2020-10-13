//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by James Monahan on 10/12/20.
//

import Foundation

class WeatherLocation: Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

