//
//  ForecastRealm.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import RealmSwift

final class ForecastRealm: Object {
    let config = Realm.Configuration(
        schemaVersion: 5)
    
    @objc dynamic var cityName: String = ""
    @objc dynamic var dayOrNight: String = ""
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    convenience init(cityName: String, dayOrNight: String, weatherDescription: String, id: Int, temp: Double, latitude: Double, longitude: Double) {
        self.init()
        self.cityName = cityName
        self.dayOrNight = dayOrNight
        self.weatherDescription = weatherDescription
        self.id = id
        self.temp = temp
        self.latitude = latitude
        self.longitude = longitude
    }
}
