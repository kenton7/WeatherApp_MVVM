//
//  CoordinatesDecoder.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 29.01.2024.
//

import Foundation

class CoordinatesDecoder {
    class func decodeCoordinates(with data: Data?) -> Coordinates? {
        guard let coordinates = data else {
            print("cant' get data from UserDefaults")
            return nil
        }
        
        do {
            let decodedCoordinates = try JSONDecoder().decode(Coordinates.self, from: coordinates)
            return Coordinates(latitude: decodedCoordinates.latitude, longitude: decodedCoordinates.longitude)
        } catch let error {
            print("error when decoding coordinates: \(error.localizedDescription)")
            return nil
        }
    }
}
