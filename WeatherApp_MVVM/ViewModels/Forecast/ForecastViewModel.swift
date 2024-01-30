//
//  ForecastViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation

final class ForecastViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var forecastDataSource: Observable<[ForecastModel]> = Observable(nil)
    var forecast = [ForecastModel]()
    let forecastService: IForecastService
    var forecastData = [ForecastModelNew]()
    var cellDataSource: Observable<[ForecastCellViewModel]> = Observable(nil)
    var currentWeatherService = CurrentWeatherFetch()
    var currentWeatherDataSource: Observable<CurrentWeatherModel> = Observable(nil)
    
    init(forecastService: IForecastService = ForecastFetch() ) {
        self.forecastService = forecastService
    }
    
    //MARK: - TableView methods
    func numberOfSections() -> Int {
        return forecastData.count
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return 1
    }
    
    func heightForRow() -> CGFloat {
        return 60
    }
    
    //MARK: - Current weather logic
    func getCurrentWeather(longitude: Double, latitude: Double) {
        currentWeatherService.getCurrentWeather(longitute: longitude,
                                                latitude: latitude,
                                                units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue,
                                                language: .ru) { currentWeatherResult in
            switch currentWeatherResult {
            case .success(let weatherData):
                self.currentWeatherDataSource.value = weatherData
            case .failure(let error):
                print("error when getting current weather: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Forecast logic
    func getForeast(longitude: Double, latitude: Double) {
        isLoading.value = true
        self.forecastService.getForecast(longitude: longitude,
                                         latitude: latitude,
                                         units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue, 
                                         language: .ru) { forecastResult in
            
            switch forecastResult {
            case .success(let forecast):
                let calendar = Calendar.current
                let df = DateFormatter()
                
                let factory = ForecastFactory.makeForecastModelArray(forecast)
                self.forecastDataSource.value = factory
                self.forecast = factory

                for _ in forecast.list! {
                    //Фильтруем дату для каждого дня в определенное время, 
                    //которое зависит от текущего часа (Например, сейчас 15:00),
                    //значит прогноз на другие дни показывается тоже в 15:00
                    let filteredData = forecast.list?.filter { entry in
                        let date = Date(timeIntervalSince1970: Double(entry.dt ?? 0))
                        
                        if calendar.component(.hour, from: Date()) == 00 {
                            return calendar.component(.hour, from: date) == 00
                        } else if calendar.component(.hour, from: Date()) % 3 == 0 {
                            return calendar.component(.hour, from: date) == calendar.component(.hour, from: Date())
                        } else if calendar.component(.hour, from: Date()) % 3 == 1 {
                            var today = calendar.component(.hour, from: Date()) + 2
                            if today >= 24 {
                                today = 00
                            }
                            return calendar.component(.hour, from: date) == today
                        } else if calendar.component(.hour, from: Date()) % 3 == 2 {
                            var today = calendar.component(.hour, from: Date()) + 1
                            if today >= 24 {
                                today = 00
                            }
                            return calendar.component(.hour, from: date) == today
                        } else {
                            return calendar.component(.hour, from: date) == 15
                        }
                    }
                    
                    for data in filteredData! {
                        df.dateFormat = "EEEE" // день недели
                        df.locale = Locale(identifier: "ru_RU")
                        df.timeZone = .current
                        let date = Date(timeIntervalSince1970: Double(data.dt ?? 0))
                        let dateString = df.string(from: date)
                        self.forecastData.append(ForecastModelNew(maxTemp: Int(data.main?.tempMax?.rounded() ?? 0.0), 
                                                                  minTemp: Int(data.main?.tempMin?.rounded() ?? 0.0),
                                                                  weatherID: data.weather?.first?.id ?? 0,
                                                                  weatherDescriptionFromServer: data.weather?.first?.description?.capitalizingFirstLetter() ?? "",
                                                                  date: dateString.capitalizingFirstLetter(),
                                                                  dayOrNight: String(data.weather?.first?.icon?.last ?? "d")))
                    }
                    self.mapCellData()
                    return
                }
            case .failure(let error):
                print("error getting forecast: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Mapping
    func mapCellData() {
        cellDataSource.value = forecastData.prefix(5).compactMap { ForecastCellViewModel(forecastModel: $0) }
    }
}

