//
//  ForecastFactory.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

final class ForecastFactory {
    
    //MARK: - Make Forecast Model From List
    class func makeForecastModelFromList(_ model: List) -> ForecastModel {
        return ForecastModel()
    }

    //MARK: - Make Forecast Model
    class func makeForecastModel(_ model: WeatherModelProtocol) -> ForecastModel {
        return ForecastModel(list: model.list, city: model.city)
    }
    
    //MARK: - Make Forecast Model Array
    class func makeForecastModelArray(_ model: WeatherModelProtocol) -> [ForecastModel] {
        return [ForecastModel(list: model.list, city: model.city)]
    }
}
