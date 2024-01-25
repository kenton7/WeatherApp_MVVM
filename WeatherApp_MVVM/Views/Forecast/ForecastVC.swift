//
//  ForecastVC.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import UIKit

final class ForecastVC: UIViewController {
    
    var viewModel = ForecastViewModel()
    var cellDataSource = [ForecastCellViewModel]()
    var forecastModel = [ForecastRealm]()
    var dataForecast = [ForecastModel]()
    
    var longitude: Double?
    var latitude: Double?
    
    let forecastScreenViews = ForecastScreenViews()
    
    override func loadView() {
        super.loadView()
        view = forecastScreenViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Прогноз на 5 дней"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let latitude, let longitude else { return }
        viewModel.getForeast(longitude: longitude, latitude: latitude)
        viewModel.getCurrentWeather(longitude: longitude, latitude: latitude)
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.forecastScreenViews.spinner.startAnimation(delay: 0.0, replicates: 20) : self.forecastScreenViews.spinner.stopAnimation()
            }
        }
        
        viewModel.currentWeatherDataSource.bind { [weak self] currentWeather in
            guard let self, let currentWeather = currentWeather else { return }
            DispatchQueue.main.async {
                self.forecastScreenViews.maxTemperatureLabel.text = "\(Int(currentWeather.main?.tempMax?.rounded() ?? 0.0))°"
                self.forecastScreenViews.minTemperaureLabel.text = "/\(Int(currentWeather.main?.tempMin?.rounded() ?? 0.0))°"
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            cellDataSource = data
            viewModel.forecastDataSource.bind { [weak self] data in
                guard let self, let data = data else { return }
                dataForecast = data
                DispatchQueue.main.async {
                    self.forecastScreenViews.humidityLabel.text = "\(self.dataForecast.first?.list?.first?.main?.humidity ?? 0)%"
                    self.forecastScreenViews.pressureLabel.text = "\(CalculateMeasurements.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: self.dataForecast.first?.list?.first?.main?.pressure ?? 0)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.pressure.rawValue) ?? "мм.рт.ст.")"
                    self.forecastScreenViews.windLabel.text = "\(CalculateMeasurements.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: self.dataForecast.first?.list?.first?.wind?.speed ?? 0.0)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.wind.rawValue) ?? "м/с")"
                }
            }
            reloadTableView()
        }
    }

}
