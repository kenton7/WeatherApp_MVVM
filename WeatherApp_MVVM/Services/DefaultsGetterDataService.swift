//
//  DefaultsGetterDataService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 01.02.2024.
//

import Foundation

protocol IDefaultsGetterData {
    func getDataFromUserDefaults(key: String) -> String?
}

class DefaultsGetterDataService: IDefaultsGetterData {
    
    static let shared = DefaultsGetterDataService()
    private init() {}
    
    func getDataFromUserDefaults(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
