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
    let currentWeatherService: ICurrentWeatherService
    let geoService: IGeoService
    lazy var realm = try! Realm()
    var realmDataSource = [ForecastRealm]()
    var forecastRealm: Results<ForecastRealm>!
    let realmUpdateDataService: IRealmUpdateService
    let realmSaveService: IRealmSaveService
    let realmDeleteService: IRealmDelete
    
    init(geoSrvice: IGeoService = GeoService(), 
         currentWeatherService: ICurrentWeatherService = CurrentWeatherFetch(),
         realmUpdateDataService: IRealmUpdateService,
         realmSaveService: IRealmSaveService,
         realmDeleteService: IRealmDelete) {
        self.geoService = geoSrvice
        self.currentWeatherService = currentWeatherService
        self.realmUpdateDataService = realmUpdateDataService
        self.realmSaveService = realmSaveService
        self.realmDeleteService = realmDeleteService
    }
    
    
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

    //MARK: - Updating weather in city
    func updateWeatherIn(city: String, indexPath: IndexPath, completion: @escaping () -> Void) {
        isLoading.value = true
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(_):
                self.currentWeatherService.getCurrentWeather(longitute: self.forecastRealm[indexPath.section].longitude, 
                                                             latitude: self.forecastRealm[indexPath.section].latitude,
                                                             units: DefaultsGetterDataService.shared.getDataFromUserDefaults(key: "units") ?? MeasurementsTypes.mertic.rawValue, language: .ru) { [weak self] currentWeatherDataResult in
                    guard let self else { return }
                    switch currentWeatherDataResult {
                    case .success(let weatherData):
                        realmUpdateDataService.updateDataInRealm(dataArray: self.forecastRealm,
                                                                 indexPath: indexPath,
                                                                 currentWeatherModel: weatherData) { realmModel in
                            self.realmListener.value = realmModel
                            self.realmDataSource = realmModel
                            self.mapCellData()
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
    
    //MARK: - Search city
    func searchCity(city: String) {
        self.geoService.searchCity(city) { cityResult in
            switch cityResult {
            case .success(let geoData):
                guard let localName = geoData.first?.localNames?["ru"] else { return }
                geoData.forEach {
                    guard let latitude = $0.lat, let longitude = $0.lon else { return }
                    self.currentWeatherService.getCurrentWeather(longitute: longitude, 
                                                                 latitude: latitude,
                                                                 units: DefaultsGetterDataService.shared.getDataFromUserDefaults(key: "units") ?? MeasurementsTypes.mertic.rawValue,
                                                                 language: .ru) { currentWeatherResult in
                        switch currentWeatherResult {
                        case .success(let weather):
                            let realmFactory = CurrentWeatherFactory.makeRealmModel(weather, cityName: localName)
                            self.realmDataSource = realmFactory
                            self.mapCellData()
                            self.realmSaveService.saveToDatabase(data: realmFactory)
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
    
    //MARK: - Mapping
    func mapCellData() {
        cellDataSource.value = realmDataSource.compactMap { SearchCellViewModel(forecastRealm: $0) }
    }
    
    //MARK: - Location button pressed
    func locationButtonPressed(longitude: Double, latitude: Double) {
        currentWeatherService.getCurrentWeather(longitute: longitude, 
                                                latitude: latitude,
                                                units: DefaultsGetterDataService.shared.getDataFromUserDefaults(key: "units") ?? MeasurementsTypes.mertic.rawValue,
                                                language: .ru) { weatherResult in
            switch weatherResult {
            case .success(let weatherData):
                let realmFactory = CurrentWeatherFactory.makeRealmModel(weatherData, cityName: weatherData.name)
                self.realmDataSource = realmFactory
                self.mapCellData()
                RealmSaveService.shared.saveToDatabase(data: realmFactory)
            case .failure(let error):
                print("error after location button pressed and getting current weather: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Custom delete button
    func customDeleteButton(action: UIContextualAction) -> UISwipeActionsConfiguration {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 17.0, weight: .bold, scale: .large)
        action.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
        action.backgroundColor = .red
        action.title = "Удалить"
        let config = UISwipeActionsConfiguration(actions: [action])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    //MARK: - Delete data from Realm
    func deleteDataFromRealm(indexPath: IndexPath) {
        realmDeleteService.deleteFromRealm(data: forecastRealm[indexPath.section],
                                           completion: mapCellData)
    }
    
    //MARK: - User selected row in TableView
//    func didSelectRow(indexPath: IndexPath, data: ForecastRealm) -> UIViewController {
//        let transferData = forecastRealm[indexPath.section]
//        let forecastVC = ForecastVC(latitude: transferData.latitude, longitude: transferData.longitude)
//        forecastVC.hidesBottomBarWhenPushed = false
//        return forecastVC
//    }
}
