//
//  RealmService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 30.01.2024.
//

import Foundation
import RealmSwift

protocol IRealmUpdateService {
    func updateDataInRealm(dataArray: Results<ForecastRealm>,
                           indexPath: IndexPath,
                           currentWeatherModel: CurrentWeatherModel,
                           completion: @escaping (([ForecastRealm]) -> Void) )
}

class RealmUpdateDataService: IRealmUpdateService {
    
    static let shared = RealmUpdateDataService()
    private init() {}
    lazy var realm = try! Realm()
    
    func updateDataInRealm(dataArray: Results<ForecastRealm>, 
                           indexPath: IndexPath,
                           currentWeatherModel: CurrentWeatherModel,
                           completion: @escaping (([ForecastRealm]) -> Void)) {
        if dataArray[indexPath.section].temp != currentWeatherModel.main?.temp?.rounded()
            || dataArray[indexPath.section].id != currentWeatherModel.weather?.first?.id ?? 803
            || dataArray[indexPath.section].weatherDescription != currentWeatherModel.weather?.first?.description
            || dataArray[indexPath.section].dayOrNight != String(currentWeatherModel.weather?.first?.icon?.last ?? "d") {
            DispatchQueue.main.async {
                do {
                    try self.realm.write {
                        dataArray[indexPath.section].temp = currentWeatherModel.main?.temp?.rounded() ?? 0.0
                        dataArray[indexPath.section].id = currentWeatherModel.weather?[0].id ?? 803
                        dataArray[indexPath.section].dayOrNight = String(currentWeatherModel.weather?[0].icon?.last ?? "d")
                        dataArray[indexPath.section].weatherDescription = currentWeatherModel.weather?[0].description ?? ""
                    }
                }
                catch let error {
                    print("error when updating data in Realm: \(error.localizedDescription)")
                }
            }
            let factory = CurrentWeatherFactory.makeUpdatedRealmModel(dataArray)
            completion(factory)
        } else {
            return
        }
    }
    
}


