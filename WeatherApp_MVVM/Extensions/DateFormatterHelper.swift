//
//  DateFormatterHelper.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 22.02.2024.
//

import Foundation

final class DateFormatterHelper {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // день недели
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = .current
        return formatter
    }
}
