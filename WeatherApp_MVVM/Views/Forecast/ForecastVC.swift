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
    let forecastScreenViews: ForecastScreenViews
    var longitude: Double
    var latitude: Double
    
    init(latitude: Double, longitude: Double, forecastScreenViews: ForecastScreenViews = ForecastScreenViews() ) {
        self.latitude = latitude
        self.longitude = longitude
        self.forecastScreenViews = forecastScreenViews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = forecastScreenViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getForeast(longitude: longitude, latitude: latitude)
        viewModel.getCurrentWeather(longitude: longitude, latitude: latitude)
    }
    
    //MARK: - Binding
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.forecastScreenViews.spinner.startAnimation(delay: 0.0, replicates: 20) : self.forecastScreenViews.spinner.stopAnimation()
            }
        }
        
        viewModel.currentWeatherDataSource.bind { [weak self] currentWeather in
            guard let self, 
                    let currentWeather = currentWeather else { return }
            DispatchQueue.main.async {
                self.forecastScreenViews.maxTemperatureLabel.text = "\(Int(currentWeather.main?.tempMax?.rounded() ?? 0.0))°"
                self.forecastScreenViews.minTemperaureLabel.text = "/\(Int(currentWeather.main?.tempMin?.rounded() ?? 0.0))°"
                self.forecastScreenViews.weatherImage.image = GetWeatherImage.weatherImages(id: currentWeather.weather?.first?.id ?? 803, pod: String(currentWeather.weather?.first?.icon?.last ?? "d"))
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            cellDataSource = data
            viewModel.forecastDataSource.bind { [weak self] data in
                guard let self,
                      let data = data,
                      let humidity = data.first?.list?.first?.main?.humidity,
                      let pressure = data.first?.list?.first?.main?.pressure,
                      let windSpeed = data.first?.list?.first?.wind?.speed else { return }
                dataForecast = data
                DispatchQueue.main.async {
                    self.forecastScreenViews.humidityLabel.text = "\(humidity)%"
                    self.forecastScreenViews.pressureLabel.text = "\(CalculateMeasurements.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: pressure)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.pressure.rawValue) ?? "мм.рт.ст.")"
                    self.forecastScreenViews.windLabel.text = "\(CalculateMeasurements.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: windSpeed)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.wind.rawValue) ?? "м/с")"
                }
            }
            reloadTableView()
        }
    }
}

//MARK: - Setup navigation controller
private extension ForecastVC {
    func setupNavigationController() {
        title = "Прогноз на 5 дней"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}
