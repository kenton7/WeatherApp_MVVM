//
//  MainViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation
import UIKit.UIView

final class MainViewModel {
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[MainCollectionViewCellViewModel]> = Observable(nil)
    var currentWeatherDataSource: Observable<CurrentWeatherModel> = Observable(nil)
    var dataSource: [List]?
    var coordinates: Coordinates?
    let currentWeatherService: ICurrentWeatherService
    let forecastService = ForecastFetch()
    var isDay: Bool {
        return currentWeatherDataSource.value?.weather?.first?.icon?.last == "d" ? true : false
    }
    
    init(currentWeatherService: ICurrentWeatherService = CurrentWeatherFetch() ) {
        self.currentWeatherService = currentWeatherService
    }
    
    //MARK: - CollectionView logic
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfitems() -> Int {
        return dataSource?.count ?? 0
    }
    
    //MARK: - Current Weather
    func getCurrentWeather(longitude: Double, latitude: Double) {
        isLoading.value = true
        DispatchQueue.global(qos: .userInteractive).async {
            self.currentWeatherService.getCurrentWeather(longitute: longitude, latitude: latitude,
                                                         units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue,
                                                         language: Language.ru) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let currentWeather):
                    currentWeatherDataSource.value = CurrentWeatherFactory.makeCurrentWeatherModel(currentWeather)
                    self.isLoading.value = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Forecast
    func getForecast(longitude: Double, latitude: Double) {
        isLoading.value = true
        let privateUtilityQueue = DispatchQueue.global(qos: .utility)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            self.forecastService.getForecast(longitude: longitude,
                                             latitude: latitude,
                                             units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue,
                                             language: Language.ru) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let forecast):
                    self.isLoading.value = false
                    let factoryModel = ForecastFactory.makeForecastModel(forecast)
                    if let first8Items = factoryModel.list?.prefix(8) {
                        let arr = Array(first8Items)
                        dataSource = arr
                        mapCellData()
                    }
                    
                case .failure(let error):
                    print("error when loading forecast from API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: - Mapping
    func mapCellData() {
        for i in dataSource! {
            let date = i.dateString?.components(separatedBy: "-")
            _ = String(date?[2].components(separatedBy: " ").dropFirst().joined().prefix(5) ?? "")
            cellDataSource.value = dataSource?.compactMap { MainCollectionViewCellViewModel($0) }
        }
    }
    
    //MARK: - Animate background
    func animateBackground(state: String, view: UIView) {
        guard let nightImage = UIImage(named: "nightSky"), let dayImage = UIImage(named: "BackgroundImage") else { return }
        
        if state == "d" {
            view.animateBackground(image: dayImage, on: view)
        } else {
            view.animateBackground(image: nightImage, on: view)
        }
    }
}
