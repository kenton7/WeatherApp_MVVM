//
//  SettingsCellViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation

class SettingsCellViewModel {
    
    var measurementType: Settings
    
    init(_ userSettings: Settings) {
        self.measurementType = userSettings
    }
    
}
