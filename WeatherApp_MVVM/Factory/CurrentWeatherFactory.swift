//
//  CurrentWeatherFactory.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation
import RealmSwift

final class CurrentWeatherFactory {
    
    //MARK: - Make Current Weather Model
    class func makeCurrentWeatherModel(_ model: CurrentWeatherProtocol) -> CurrentWeatherModel {
        return CurrentWeatherModel(coord: model.coord, 
                                   weather: model.weather,
                                   main: model.main,
                                   wind: model.wind,
                                   dt: model.dt,
                                   name: model.name)
    }
    
    //MARK: - Make Realm Model
    class func makeRealmModel(_ model: CurrentWeatherProtocol, cityName: String?) -> [ForecastRealm] {
        if let city = cityName,
           let weatherDescription = model.weather?.first?.description,
           let temp = model.main?.temp?.rounded(),
           let dayOrNight = model.weather?.first?.icon?.last,
           let id = model.weather?.first?.id,
           let latitude = model.coord?.lat,
           let longitude = model.coord?.lon {
            return [
                ForecastRealm(cityName: city,
                              dayOrNight: String(dayOrNight),
                              weatherDescription: weatherDescription,
                              id: id,
                              temp: temp,
                              latitude: latitude,
                              longitude: longitude)
            ]
        }
        return [ForecastRealm]()
    }
    
    //MARK: - Make Updated Realm Model
    class func makeUpdatedRealmModel(_ model: Results<ForecastRealm>) -> [ForecastRealm] {
        
        for data in model {
            return [
                ForecastRealm(cityName: data.cityName,
                                  dayOrNight: data.dayOrNight,
                                  weatherDescription: data.weatherDescription,
                                  id: data.id,
                                  temp: data.temp,
                                  latitude: data.latitude,
                                  longitude: data.longitude)
            ]
        }
        return [ForecastRealm]()
    }
}
