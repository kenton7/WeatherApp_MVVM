//
//  ForecastFactory.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

class ForecastFactory {
    class func makeForecastModel(_ model: WeatherModelProtocol) -> ForecastModel {
        return ForecastModel(list: model.list, city: model.city)
    }
}
