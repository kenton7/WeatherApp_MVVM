//
//  ForecastScreenViews.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 25.01.2024.
//

import UIKit

final class ForecastScreenViews: UIView {
    
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
    
    lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--°"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    lazy var minTemperatureLabel: UILabel = {
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
    
    private let windStackView: UIStackView = {
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
    
    private let pressureImage: UIImageView = {
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
    
    private let pressureName: UILabel = {
        let label = UILabel()
        label.text = "Давление"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityImage: UIImageView = {
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
    
    private let humidityName: UILabel = {
        let label = UILabel()
        label.text = "Влажность"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windImage: UIImageView = {
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
    
    private let windName: UILabel = {
        let label = UILabel()
        label.text = "Ветер"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views
    private func setupViews() {
        backgroundColor = UIColor(red: 0.28, green: 0.19, blue: 0.62, alpha: 1)
        addSubview(tableView)
        addSubview(weatherView)
        addSubview(weatherImage)
        addSubview(maxTemperatureLabel)
        addSubview(minTemperatureLabel)
        addSubview(detailStackView)
        addSubview(spinner)
        
        detailStackView.addArrangedSubview(pressureStackView)
        detailStackView.addArrangedSubview(humidityStackView)
        detailStackView.addArrangedSubview(windStackView)
        pressureStackView.addArrangedSubview(pressureImage)
        pressureStackView.addArrangedSubview(pressureLabel)
        pressureStackView.addArrangedSubview(pressureName)
        humidityStackView.addArrangedSubview(humidityImage)
        humidityStackView.addArrangedSubview(humidityLabel)
        humidityStackView.addArrangedSubview(humidityName)
        windStackView.addArrangedSubview(windImage)
        windStackView.addArrangedSubview(windLabel)
        windStackView.addArrangedSubview(windName)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherView.heightAnchor.constraint(equalToConstant: 250),
            weatherView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weatherView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            weatherImage.leadingAnchor.constraint(equalTo: weatherView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            weatherImage.topAnchor.constraint(equalTo: weatherView.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherImage.heightAnchor.constraint(equalToConstant: 120),
            weatherImage.widthAnchor.constraint(equalToConstant: 120),
            
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 16),
            maxTemperatureLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 10),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 0),
            minTemperatureLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 40),
            
            humidityStackView.topAnchor.constraint(equalTo: pressureStackView.topAnchor),
            humidityImage.heightAnchor.constraint(equalToConstant: 24),
            humidityLabel.centerXAnchor.constraint(equalTo: humidityImage.centerXAnchor),
            windImage.heightAnchor.constraint(equalToConstant: 24),
            pressureImage.heightAnchor.constraint(equalToConstant: 24),
            
            detailStackView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            detailStackView.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 5),
            detailStackView.widthAnchor.constraint(equalTo: weatherView.widthAnchor, multiplier: 0.9),
            detailStackView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: weatherView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
