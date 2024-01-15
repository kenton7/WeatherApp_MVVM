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
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "cloudy-weather")
        return image
    }()
    
    private lazy var weatherDescription: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.94
        label.attributedText = NSMutableAttributedString(string: "--",
                                                         attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.alpha = 0.3
        button.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button.setImage(UIImage(named: "refresh"), for: .normal)
        button.tintColor = .black
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE, d MMMM yyy"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        df.locale = Locale(identifier: "ru-RU")
        let dateString = df.string(from: date)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.94
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString(string: dateString.capitalized,
                                                         attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var pressureImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pressure")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var pressureName: UILabel = {
        let label = UILabel()
        label.text = "Давление"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var humidityImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "insurance 1 (1)")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var humidityName: UILabel = {
        let label = UILabel()
        label.text = "Влажность"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var windImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "insurance 1 (2)")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var windName: UILabel = {
        let label = UILabel()
        label.text = "Ветер"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: -- Stack Views
    private lazy var detailStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .horizontal
        view.backgroundColor = UIColor(red: 0.32, green: 0.25, blue: 0.5, alpha: 1)
        view.layer.cornerRadius = 8
        view.alpha = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private lazy var weatherDataStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var visibilityStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    private lazy var winddStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    private lazy var sevenDaysForecast: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Прогноз"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        return label
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var spinner: CustomSpinner = {
        let spinner = CustomSpinner(squareLength: 100)
        spinner.isHidden = true
        return spinner
    }()
    
    var coordinates: Coordinates?
    
    var viewModel = MainViewModel()
    var cellDataSource = [MainCollectionViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupCollectionView()
        bindViewModel()
        
        refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.spinner.startAnimation(delay: 0.0, replicates: 20) : self.spinner.stopAnimation()
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
                self.animateBackground(state: String(data.weather?.first?.icon?.last ?? "d"))
                
                self.temperatureLabel.text = "\(Int(data.main?.temp?.rounded() ?? 0))°"
                self.cityLabel.text = data.name
                self.humidityLabel.text = "\(Int(data.main?.humidity ?? 0))%"
                self.windLabel.text = "\(CalculateMeasurements.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: Double(Int(data.wind?.speed?.rounded() ?? 0)))) \(UserDefaults.standard.string(forKey: "windTitle") ?? "м/с")"
                self.weatherDescription.text = data.weather?.first?.description?.capitalizingFirstLetter()
                self.pressureLabel.text = "\(CalculateMeasurements.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: data.main?.pressure ?? 0)) \(UserDefaults.standard.string(forKey: "pressureTitle") ?? "мм.рт.ст.")"
                self.weatherImage.image = GetWeatherImage.weatherImages(id: data.weather?.first?.id ?? 803, pod: String(data.weather?.first?.icon?.last ?? "d"))
            }
        }
    }

    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(weatherImage)
        view.addSubview(weatherDescription)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        view.addSubview(refreshButton)
        view.addSubview(dateLabel)
        view.addSubview(detailStackView)
        view.addSubview(weatherDataStackView)
        view.addSubview(visibilityStackView)
        view.addSubview(humidityStackView)
        view.addSubview(winddStackView)
        view.addSubview(sevenDaysForecast)
        view.addSubview(todayLabel)
        view.addSubview(spinner)
        view.addSubview(windName)
        view.addSubview(windImage)
        view.addSubview(windLabel)
        view.addSubview(winddStackView)
        weatherDataStackView.addArrangedSubview(weatherDescription)
        weatherDataStackView.addArrangedSubview(weatherImage)
        weatherDataStackView.addArrangedSubview(temperatureLabel)
        weatherDataStackView.addArrangedSubview(dateLabel)
        visibilityStackView.addArrangedSubview(pressureImage)
        visibilityStackView.addArrangedSubview(pressureLabel)
        visibilityStackView.addArrangedSubview(pressureName)
        humidityStackView.addArrangedSubview(humidityImage)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityName)
        winddStackView.addArrangedSubview(windImage)
        winddStackView.addArrangedSubview(windLabel)
        winddStackView.addArrangedSubview(windName)
        detailStackView.addArrangedSubview(visibilityStackView)
        detailStackView.addArrangedSubview(humidityStackView)
        detailStackView.addArrangedSubview(winddStackView)
    }
    
    func animateBackground(state: String) {
        guard let nightImage = UIImage(named: "nightSky"), let dayImage = UIImage(named: "BackgroundImage") else { return }
        
        if state == "d" {
            self.view.animateBackground(image: dayImage, on: self.view)
        } else {
            self.view.animateBackground(image: nightImage, on: self.view)
        }
    }
    
    @objc private func refreshButtonPressed() {
        let privateQueue = DispatchQueue.global(qos: .utility)
        
        DispatchQueue.main.async {
            self.spinner.isHidden = false
            self.spinner.startAnimation(delay: 0.0, replicates: 20)
        }
        
        privateQueue.async { [weak self] in
            if let coordinates = UserDefaults.standard.data(forKey: "coordinates") {
                let decodedCoordinates = try! JSONDecoder().decode(Coordinates.self, from: coordinates)
                guard let self else { return }
                self.viewModel.getCurrentWeather(longitude: decodedCoordinates.longitude, latitude: decodedCoordinates.latitude)
                self.viewModel.getForecast(longitude: decodedCoordinates.longitude, latitude: decodedCoordinates.latitude)
            }
        }
    }
}

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            refreshButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 46),
            refreshButton.widthAnchor.constraint(equalToConstant: 46),
            refreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            weatherDescription.heightAnchor.constraint(equalToConstant: 30),
            weatherDataStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescription.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            
            weatherImage.widthAnchor.constraint(equalToConstant: 150),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60),
            dateLabel.heightAnchor.constraint(equalToConstant: 15),

            pressureImage.heightAnchor.constraint(equalToConstant: 24),

            humidityStackView.topAnchor.constraint(equalTo: visibilityStackView.topAnchor),
            humidityImage.heightAnchor.constraint(equalToConstant: 24),
            humidityLabel.centerXAnchor.constraint(equalTo: humidityImage.centerXAnchor),
            humidityStackView.centerXAnchor.constraint(equalTo: detailStackView.centerXAnchor),

            windImage.heightAnchor.constraint(equalToConstant: 24),
            
            detailStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            detailStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            detailStackView.heightAnchor.constraint(equalToConstant: 100),
            detailStackView.topAnchor.constraint(equalTo: weatherDataStackView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            sevenDaysForecast.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sevenDaysForecast.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 10),
            
            todayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            todayLabel.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: sevenDaysForecast.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
