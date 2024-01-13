//
//  SearchTableViewCell.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let cellID = "SearchTableViewCell"
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "cloudy-weather")
        return image
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--°"
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    private let stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        clipsToBounds = false
        backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
        alpha = 0.8
        layer.cornerRadius = 15
        isUserInteractionEnabled = true
        selectionStyle = .none
        
        addSubview(stackView)
        addSubview(weatherImage)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(weatherDescriptionLabel)
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            weatherImage.heightAnchor.constraint(equalToConstant: 90),
            weatherImage.widthAnchor.constraint(equalToConstant: 110),
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            cityLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor, constant: -5),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    func setupCell(_ model: SearchCellViewModel, indexPath: IndexPath) {
//        weatherImage.image = GetWeatherImage.weatherImages(id: model.currentWeather?.weather?[indexPath.row].id ?? 803, pod: String(model.currentWeather?.weather?.first?.icon?.last ?? "d"))
//        cityLabel.text = model.currentWeather?.name
//        temperatureLabel.text = "\(Int(model.currentWeather?.main?.temp?.rounded() ?? 0))°"
//        weatherDescriptionLabel.text = model.currentWeather?.weather?[indexPath.row].description?.capitalizingFirstLetter()
//    }
    
    func setupCellNew(_ model: ForecastRealm) {
        weatherImage.image = GetWeatherImage.weatherImages(id: model.id, pod: model.dayOrNight)
        temperatureLabel.text = "\(Int(model.temp))°"
        weatherDescriptionLabel.text = model.weatherDescription.capitalizingFirstLetter()
        cityLabel.text = model.cityName
    }

}
