//
//  ForecastCellViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation

final class ForecastCellViewModel {
    
    var forecastModel: ForecastModelNew
    
    init(forecastModel: ForecastModelNew) {
        self.forecastModel = forecastModel
    }
}
