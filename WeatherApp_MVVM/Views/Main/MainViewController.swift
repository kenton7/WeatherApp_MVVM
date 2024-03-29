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
    var calculateMeasurementsService: ICalculateMeasurements
    let weatherImageService: IGetWeatherImage
    
    init(weatherImageService: IGetWeatherImage, calculateMeasurementsService: ICalculateMeasurements) {
        self.weatherImageService = weatherImageService
        self.calculateMeasurementsService = calculateMeasurementsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            self.cellDataSource = data
            reloadCollectionView()
        }
        
        viewModel.currentWeatherDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            DispatchQueue.main.async {
                self.viewModel.animateBackground(isDay: self.viewModel.isDay, view: self.view)
                self.mainScreenViews.temperatureLabel.text = "\(Int(data.main?.temp?.rounded() ?? 0))°"
                self.mainScreenViews.cityLabel.text = data.name
                self.mainScreenViews.humidityLabel.text = "\(Int(data.main?.humidity ?? 0))%"
                self.mainScreenViews.weatherDescription.text = data.weather?.first?.description?.capitalizingFirstLetter()
                self.mainScreenViews.pressureLabel.text = "\(self.calculateMeasurementsService.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: data.main?.pressure ?? 0)) \(DefaultsGetterDataService.shared.getDataFromUserDefaults(key: "pressureTitle") ?? "мм.рт.ст.")"
                self.mainScreenViews.windLabel.text = "\(self.calculateMeasurementsService.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: Double(Int(data.wind?.speed?.rounded() ?? 0)))) \(DefaultsGetterDataService.shared.getDataFromUserDefaults(key: "windTitle") ?? "м/с")"
                self.mainScreenViews.weatherImage.image = self.weatherImageService.weatherImages(id: data.weather?.first?.id ?? 803, pod: String(data.weather?.first?.icon?.last ?? "d"))
            }
        }
    }
    
    //MARK: - Refresh button pressed method
    @objc private func refreshButtonPressed() {
        locationManager.startUpdatingLocation()
        guard let longitude = locationManager.location?.coordinate.longitude, 
                let latitude = locationManager.location?.coordinate.latitude else { return }
        viewModel.getCurrentWeather(longitude: longitude, latitude: latitude)
        viewModel.getForecast(longitude: longitude, latitude: latitude)
        locationManager.stopUpdatingLocation()
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
