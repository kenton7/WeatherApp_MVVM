//
//  CalculateMeasurements.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

protocol ICalculateMeasurements {
    func calculatePressure(measurementIndex: Int, value: Int) -> Int
    func calculateWindSpeed(measurementIndex: Int, value: Double) -> Int
}

final class CalculateMeasurements: ICalculateMeasurements {
    /// Функция переводит давление в другую систему исчисления
    /// - Parameters:
    ///   - measurementIndex: Индекс сегментед контhола, который выбрал юзер
    ///   - value: значение давления, полученное с сервера
    /// - Returns: возвращаем результат в другой системе исчисления

    let fromMmRtStToHPa = 0.750064
    let fromHPaToHg = 0.02953
    
    func calculatePressure(measurementIndex: Int, value: Int) -> Int {
        var result = 0
        switch measurementIndex {
        case 0:
            result = Int((Double(value) * fromMmRtStToHPa).rounded())
        case 1:
            result = value
        case 2:
            result = Int((Double(value) * fromHPaToHg).rounded())
        default:
            return 0
        }
        return result
    }
    
    
    //MARK: - Calculate wind speed
    /// Функция переводит скорость ветра в разные системы исчисления
    /// - Parameters:
    ///   - measurementIndex: Индекс сегментед контрола
    ///   - value: Значение скорости ветра, полученное с сервера
    /// - Returns: Возвращаем результат в другой системе исчисления
    
    let fromMetersPerSecondToKmPerHour = 3.6
    let fromMetersPerSecondToMilesPerHour = 2.2369362920544
    
    func calculateWindSpeed(measurementIndex: Int, value: Double) -> Int {
        var result = 0
        switch measurementIndex {
        case 0:
            result = Int(value.rounded())
        case 1:
            result = Int((value * fromMetersPerSecondToKmPerHour).rounded())
        case 2:
            result = Int((value * fromMetersPerSecondToMilesPerHour).rounded())
        default:
            return 0
        }
        return result
    }
}
