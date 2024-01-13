//
//  Coordinates.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

class CoordinatesNew: Codable {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init() {
        self.init(latitude: 0.0, longitude: 0.0)
    }
}
