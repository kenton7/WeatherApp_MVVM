//
//  DefaultsSaverService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 01.02.2024.
//

import Foundation

protocol IDefaultSaverService {
    func saveToUserDefaults<T>(data: T, key: String)
}

final class DefaultsSaverService: IDefaultSaverService {
    
    static let shared = DefaultsSaverService()
    private init() {}
    
    func saveToUserDefaults<T>(data: T, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
}
