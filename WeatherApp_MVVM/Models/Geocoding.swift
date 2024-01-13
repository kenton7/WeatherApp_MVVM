//
//  Geocoding.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation

struct GeocodingElement: Codable {
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias Geocoding = [GeocodingElement]
