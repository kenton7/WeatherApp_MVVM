//
//  MainViewController.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    var coordinates: Coordinates?
    var viewModel = MainViewModel()
    var cellDataSource = [MainCollectionViewCellViewModel]()
    let mainScreenViews = MainScreenViews()
    
    override func loadView() {
        super.loadView()
        view = mainScreenViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindViewModel()
        
        mainScreenViews.refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAndStartLocationManager()
    }
    
    //MARK: - Bindings
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.mainScreenViews.spinner.startAnimation(delay: 0.0, replicates: 20) : self.mainScreenViews.spinner.stopAnimation()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            cellDataSource = data
            reloadCollectionView()
        }
        
        viewModel.currentWeatherDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            DispatchQueue.main.async {
                self.viewModel.animateBackground(state: String(data.weather?.first?.icon?.last ?? "d"), view: self.mainScreenViews)
                self.mainScreenViews.temperatureLabel.text = "\(Int(data.main?.temp?.rounded() ?? 0))°"
                self.mainScreenViews.cityLabel.text = data.name
                self.mainScreenViews.humidityLabel.text = "\(Int(data.main?.humidity ?? 0))%"
                self.mainScreenViews.windLabel.text = "\(CalculateMeasurements.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: Double(Int(data.wind?.speed?.rounded() ?? 0)))) \(UserDefaults.standard.string(forKey: "windTitle") ?? "м/с")"
                self.mainScreenViews.weatherDescription.text = data.weather?.first?.description?.capitalizingFirstLetter()
                self.mainScreenViews.pressureLabel.text = "\(CalculateMeasurements.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: data.main?.pressure ?? 0)) \(UserDefaults.standard.string(forKey: "pressureTitle") ?? "мм.рт.ст.")"
                self.mainScreenViews.weatherImage.image = GetWeatherImage.weatherImages(id: data.weather?.first?.id ?? 803, pod: String(data.weather?.first?.icon?.last ?? "d"))
            }
        }
    }
    
    //MARK: - Refresh button pressed method
    @objc private func refreshButtonPressed() {
        if let coordinates = CoordinatesDecoder.decodeCoordinates(with: UserDefaults.standard.data(forKey: "coordinates")) {
            self.viewModel.getCurrentWeather(longitude: coordinates.longitude, latitude: coordinates.latitude)
            self.viewModel.getForecast(longitude: coordinates.latitude, latitude: coordinates.longitude)
        }
    }
}

//MARK: - Setup location manager
private extension MainViewController {
    func setupAndStartLocationManager() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
}
