//
//  SearchVCViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import RealmSwift
import UIKit.UIImage

final class SearchVCViewModel {
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[SearchCellViewModel]> = Observable(nil)
    var realmListener: Observable<[ForecastRealm]> = Observable(nil)
    let currentWeatherService = CurrentWeatherFetch()
    let geoService = GeoService()
    lazy var realm = try! Realm()
    var realmDataSource = [ForecastRealm]()
    var forecastRealm: Results<ForecastRealm>!
    
    func numberOfSections() -> Int {
        return forecastRealm.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return 1
    }
    
    func heightForRow() -> CGFloat {
        return 100
    }
    
    func heightForHeader() -> CGFloat {
        return 40
    }
    
    func heightForFooter() -> CGFloat {
        return 15
    }

    func updateWeatherIn(city: String, indexPath: IndexPath, completion: @escaping () -> Void) {
        isLoading.value = true
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(let geoData):
                guard let localName = geoData.first?.localNames?["ru"] else { return }
                self.currentWeatherService.getCurrentWeather(longitute: self.forecastRealm[indexPath.section].longitude, 
                                                             latitude: self.forecastRealm[indexPath.section].latitude,
                                                             units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue, language: .ru) { currentWeatherDataResult in
                    switch currentWeatherDataResult {
                    case .success(let weatherData):
                        if self.forecastRealm[indexPath.section].temp != weatherData.main?.temp?.rounded() ?? 0.0 || self.forecastRealm[indexPath.section].id != weatherData.weather?[0].id ?? 803 || self.forecastRealm[indexPath.section].weatherDescription != weatherData.weather?[0].description ?? "" ||
                            self.forecastRealm[indexPath.section].dayOrNight != String(weatherData.weather?[0].icon?.last ?? "d") {
                            let realmFactory = CurrentWeatherFactory.makeRealmModel(weatherData, cityName: localName)
                            self.realmListener.value = realmFactory
                            self.realmDataSource = realmFactory
                            self.mapCellData()
                            DispatchQueue.main.async {
                                do {
                                    try self.realm.write {
                                        self.forecastRealm[indexPath.section].id = weatherData.weather?[0].id ?? 803
                                        self.forecastRealm[indexPath.section].dayOrNight = String(weatherData.weather?[0].icon?.last ?? "d")
                                        self.forecastRealm[indexPath.section].temp = weatherData.main?.temp?.rounded() ?? 0.0
                                        self.forecastRealm[indexPath.section].weatherDescription = weatherData.weather?[0].description ?? ""
                                    }
                                }
                                catch let error {
                                    print("error when updating data in Realm: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            return
                        }
                    case .failure(let error):
                        print("error when gettting current weather: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("error when searching city: \(error.localizedDescription)")
                completion()
            }
        }
        isLoading.value = false
    }
    
    func searchCity(city: String) {
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(let geoData):
                guard let localName = geoData.first?.localNames?["ru"] else { return }
                geoData.forEach {
                    guard let latitude = $0.lat, let longitude = $0.lon else { return }
                    self.currentWeatherService.getCurrentWeather(longitute: longitude, latitude: latitude, units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue, language: .ru) { currentWeatherResult in
                        switch currentWeatherResult {
                        case .success(let weather):
                            let realmFactory = CurrentWeatherFactory.makeRealmModel(weather, cityName: localName)
                            self.realmDataSource = realmFactory
                            self.mapCellData()
                            DispatchQueue.main.async {
                                do {
                                    try self.realm.write {
                                        self.realm.add(self.realmDataSource)
                                    }
                                }
                                catch let error {
                                    print("error when saving data in Realm: \(error.localizedDescription)")
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print("error searching city: \(error.localizedDescription)")
            }
        }
    }
    
    func mapCellData() {      
        cellDataSource.value = realmDataSource.compactMap { SearchCellViewModel(forecastRealm: $0) }
    }
    
    func locationButtonPressed(longitude: Double, latitude: Double) {
        currentWeatherService.getCurrentWeather(longitute: longitude, latitude: latitude, units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue, language: .ru) { weatherResult in
            switch weatherResult {
            case .success(let weatherData):
                let realmFactory = CurrentWeatherFactory.makeRealmModel(weatherData, cityName: weatherData.name)
                self.realmDataSource = realmFactory
                self.mapCellData()
                DispatchQueue.main.async {
                    do {
                        try self.realm.write {
                            self.realm.add(self.realmDataSource)
                        }
                    }
                    catch let error {
                        print("error when saving data in Realm: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("error after location button pressed and getting current weather: \(error.localizedDescription)")
            }
        }
    }
    
    func customDeleteButton(action: UIContextualAction) -> UISwipeActionsConfiguration {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        action.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        action.backgroundColor = .red
        action.title = "Удалить"
        let config = UISwipeActionsConfiguration(actions: [action])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func deleteDataFromRealm(indexPath: IndexPath) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.delete(self.forecastRealm[indexPath.section])
                }
                self.mapCellData()
            }
            catch let error {
                print("error when trying to delete data from Realm: \(error.localizedDescription)")
            }
        }
    }
    
    func didSelectRow(indexPath: IndexPath, data: ForecastRealm) {
        let transferData = forecastRealm[indexPath.section]
        let forecastVC = ForecastVC()
        forecastVC.hidesBottomBarWhenPushed = false
    }
}
