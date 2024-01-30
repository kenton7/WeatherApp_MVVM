//
//  SearchCellViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation

final class SearchCellViewModel {
    
    var forecastRealm: ForecastRealm?
    
    init(forecastRealm: ForecastRealm) {
        self.forecastRealm = forecastRealm
    }
}
