//
//  SearchVCViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import UIKit
import RealmSwift

class SearchVCViewModel {
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[SearchCellViewModel]> = Observable(nil)
    var currentWeatherDataSource: Observable<[SearchCellViewModel]> = Observable(nil)
    var dataSource = [CurrentWeatherModel]()
    //var realmListener: Observable<[SearchCellViewModel]> = Observable(nil)
    let currentWeatherService = CurrentWeatherFetch()
    let geoService = GeoService()
    lazy var realm = try! Realm()
    var realmDataSource = [ForecastRealm]()
    var forecastRealm: Results<ForecastRealm>!
    
    
    func numberOfSections() -> Int {
        return forecastRealm.count
        //return dataSource.count
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
    
    //-------
    func updateWeatherIn(city: String, indexPath: IndexPath) {
        print("OPS \(city)")
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(let geoData):
                geoData.forEach {
                    print("local names: \($0.name)")
                }
                guard let localName = geoData.first?.localNames?["ru"] else { return }
                print(localName)
                //guard let longitude = self.forecastRealm[indexPath.section].longitude, let latitude = self.forecastRealm[indexPath.section].latitude else { return }
               //guard let longitude = geoData.first?.lon, let latitude = geoData.first?.lat else { return }
                self.currentWeatherService.getCurrentWeather(longitute: self.forecastRealm[indexPath.section].longitude, latitude: self.forecastRealm[indexPath.section].latitude, units: UserDefaults.standard.string(forKey: "units") ?? "metric", language: .ru) { currentWeatherDataResult in
                    switch currentWeatherDataResult {
                    case .success(let weatherData):
                        print("Погода в \(weatherData.name): \(weatherData.weather?.first?.description), температура = \(weatherData.main?.temp)")
                        let realmFactory = CurrentWeatherFactory.makeRealmModel(weatherData, cityName: localName)
                        let weatherFactory = CurrentWeatherFactory.makeCurrentWeatherModelArray(weatherData)
                        self.realmDataSource = realmFactory
                        self.dataSource = weatherFactory
                        //self.mapCellData()
                        print("indexPath: \(self.forecastRealm[indexPath.section].cityName)")
                        DispatchQueue.main.async {
                            do {
                                try self.realm.write {
                                    //self.forecastRealm[indexPath.section].cityName = geoData.first?.localNames?["ru"] ?? "ru"
                                    self.forecastRealm[indexPath.section].id = weatherData.weather?[0].id ?? 803
                                    self.forecastRealm[indexPath.section].dayOrNight = String(weatherData.weather?[0].icon?.last ?? "d")
                                    self.forecastRealm[indexPath.section].temp = weatherData.main?.temp?.rounded() ?? 0.0
                                    self.forecastRealm[indexPath.section].latitude = weatherData.coord?.lat ?? 0.0
                                    self.forecastRealm[indexPath.section].longitude = weatherData.coord?.lon ?? 0.0
                                }
                            }
                            catch let error {
                                print("error when updating data in Realm: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("error when gettting current weather: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("error when searching city: \(error.localizedDescription)")
            }
        }
    }
    
    //РАБОТАЕТ
    func searchCity(city: String) {
        isLoading.value = true
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(let geoData):
                guard let localName = geoData.first?.localNames?["ru"] else { return }
                geoData.forEach {
                    guard let latitude = $0.lat, let longitude = $0.lon else { return }
                    self.currentWeatherService.getCurrentWeather(longitute: longitude, latitude: latitude, units: UserDefaults.standard.string(forKey: "units") ?? "metric", language: .ru) { currentWeatherResult in
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
}
