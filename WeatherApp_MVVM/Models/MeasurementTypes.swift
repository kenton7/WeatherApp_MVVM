//
//  MeasurementTypes.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 29.01.2024.
//

import Foundation

enum MeasurementsTypes: String {
    case mmRtSt = "мм.рт.ст."
    case hPa = "гПа"
    case dRtSt = "д.рт.ст."
    case metersPerSecond = "м/c"
    case kilometerPerHour = "км/ч"
    case milesPerHour = "ми/ч"
    case mertic = "metric"
    case imperial = "imperial"
    case wind = "windTitle"
    case pressure = "pressureTitle"
}

enum TitlesForSections: String {
    case temperature = "Температура"
    case other = "Другие единицы измерения"
}
