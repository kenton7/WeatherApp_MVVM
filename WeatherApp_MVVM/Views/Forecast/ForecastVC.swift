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
        
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "cloudy-weather")
        return image
    }()
    
    private lazy var weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var weatherStackView: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--°"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    private lazy var minTemperaureLabel: UILabel = {
        let label = UILabel()
        label.text = "/ --°"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.cellID)
        return tableView
    }()
    
    //MARK: -- Stack Views
    private let detailStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .horizontal
        view.layer.cornerRadius = 8
        view.alpha = 0.8
        return view
    }()
    
    private let pressureStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    private let humidityStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    private let winddStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .vertical
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.spacing = 8
        return view
    }()
    
    lazy var spinner: CustomSpinner = {
        let spinner = CustomSpinner(squareLength: 100)
        spinner.isHidden = true
        return spinner
    }()
    
    let pressureImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "pressure")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let pressureName: UILabel = {
        let label = UILabel()
        label.text = "Давление"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "insurance 1 (1)")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let humidityName: UILabel = {
        let label = UILabel()
        label.text = "Влажность"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let windImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "insurance 1 (2)")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let windName: UILabel = {
        let label = UILabel()
        label.text = "Ветер"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Прогноз на 5 дней"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

        setupViews()
        setupTableView()
        setConstraints()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let latitude, let longitude else { return }
        viewModel.getForeast(longitude: longitude, latitude: latitude)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(red: 0.28, green: 0.19, blue: 0.62, alpha: 1)
        view.addSubview(tableView)
        view.addSubview(weatherView)
        view.addSubview(weatherImage)
        view.addSubview(maxTemperatureLabel)
        view.addSubview(minTemperaureLabel)
        view.addSubview(detailStackView)
        view.addSubview(spinner)
        
        detailStackView.addArrangedSubview(pressureStackView)
        detailStackView.addArrangedSubview(humidityStackView)
        detailStackView.addArrangedSubview(winddStackView)
        pressureStackView.addArrangedSubview(pressureImage)
        pressureStackView.addArrangedSubview(pressureLabel)
        pressureStackView.addArrangedSubview(pressureName)
        humidityStackView.addArrangedSubview(humidityImage)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityName)
        winddStackView.addArrangedSubview(windImage)
        winddStackView.addArrangedSubview(windLabel)
        winddStackView.addArrangedSubview(windName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherView.heightAnchor.constraint(equalToConstant: 250),
            weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            weatherImage.leadingAnchor.constraint(equalTo: weatherView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            weatherImage.topAnchor.constraint(equalTo: weatherView.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 120),
            weatherImage.widthAnchor.constraint(equalToConstant: 120),
            
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 16),
            maxTemperatureLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 10),
            minTemperaureLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 0),
            minTemperaureLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 40),
            
            humidityStackView.topAnchor.constraint(equalTo: pressureStackView.topAnchor),
            humidityImage.heightAnchor.constraint(equalToConstant: 24),
            humidityLabel.centerXAnchor.constraint(equalTo: humidityImage.centerXAnchor),
            windImage.heightAnchor.constraint(equalToConstant: 24),
            pressureImage.heightAnchor.constraint(equalToConstant: 24),
            
            detailStackView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            detailStackView.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 5),
            detailStackView.widthAnchor.constraint(equalTo: weatherView.widthAnchor, multiplier: 0.9),
            detailStackView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.spinner.startAnimation(delay: 0.0, replicates: 20) : self.spinner.stopAnimation()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            cellDataSource = data
            DispatchQueue.main.async {
                self.maxTemperatureLabel.text = "\(self.cellDataSource.first?.forecastModel.maxTemp ?? 0)°"
                self.minTemperaureLabel.text = "/\(self.cellDataSource.first?.forecastModel.minTemp ?? 0)°"
            }
            
            viewModel.forecastDataSource.bind { [weak self] data in
                guard let self, let data = data else { return }
                dataForecast = data
                DispatchQueue.main.async {
                    self.humidityLabel.text = "\(self.dataForecast.first?.list?.first?.main?.humidity ?? 0)%"
                    self.pressureLabel.text = "\(CalculateMeasurements.calculatePressure(measurementIndex: UserDefaults.standard.integer(forKey: "pressureIndex"), value: self.dataForecast.first?.list?.first?.main?.pressure ?? 0)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.pressure.rawValue) ?? "мм.рт.ст.")"
                    self.windLabel.text = "\(CalculateMeasurements.calculateWindSpeed(measurementIndex: UserDefaults.standard.integer(forKey: "windIndex"), value: self.dataForecast.first?.list?.first?.wind?.speed ?? 0.0)) \(UserDefaults.standard.string(forKey: MeasurementsTypes.wind.rawValue) ?? "м/с")"
                }
            }
            reloadTableView()
        }
    }

}
