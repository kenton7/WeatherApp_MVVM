//
//  Settings.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation

enum MeasureType: String, CaseIterable {
    case celcius = "Градусы Цельсия (°C)"
    case farengeight = "Градусы Фаренгейта (°F)"
    case wind = "Ветер"
    case pressure = "Давление"
}

struct Settings {
    
    var typeOfMeasurements: MeasureType
    
}
