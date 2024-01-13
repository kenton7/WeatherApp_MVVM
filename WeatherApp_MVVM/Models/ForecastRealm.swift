//
//  ForecastRealm.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import RealmSwift

class ForecastRealm: Object {
    let config = Realm.Configuration(
        schemaVersion: 5)
    
    @objc dynamic var cityName: String = ""
    @objc dynamic var dayOrNight: String = ""
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var temp: Double = 0.0
    //@objc dynamic var weatherImage: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
//    @objc dynamic var tempMin: Double = 0.0
//    @objc dynamic var tempMax: Double = 0.0
//    @objc dynamic var pressure: Int = 0
//    @objc dynamic var humidity: Int = 0
//    @objc dynamic var windSpeed: Double = 0.0
//    @objc dynamic var selectedItem: Int = 0
//    @objc dynamic var date: String = ""
    
    
//        override class func primaryKey() -> String? {
//                return "id"
//            }
    
    convenience init(cityName: String, dayOrNight: String, weatherDescription: String, id: Int, temp: Double, latitude: Double, longitude: Double) {
        self.init()
        self.cityName = cityName
        self.dayOrNight = dayOrNight
        self.weatherDescription = weatherDescription
        self.id = id
        self.temp = temp
        self.latitude = latitude
        self.longitude = longitude
        //self.weatherImage = weatherImage
    }
    
    
//    convenience init(cityName: String, dayOrNight: String, weatherDescription: String, id: Int, temp: Double, latitude: Double, longitude: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, windSpeed: Double, selectedItem: Int, date: String) {
//        self.init()
//        self.cityName = cityName
//       // self.dayOrNight = dayOrNight
//        self.weatherDescription = weatherDescription
//        //self.id = id
//        self.temp = temp
//        //self.latitude = latitude
//        //self.longitude = longitude
//        //self.tempMin = tempMin
//        //self.tempMax = tempMax
//        //self.pressure = pressure
//        //self.humidity = humidity
//        //self.windSpeed = windSpeed
//        //self.selectedItem = selectedItem
//        //self.date = date
//    }
}
