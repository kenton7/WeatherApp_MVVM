//
//  MainScreenViews.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 25.01.2024.
//

import UIKit

final class MainScreenViews: UIView {

    lazy var spinner: CustomSpinner = {
        let spinner = CustomSpinner(squareLength: 100)
        spinner.isHidden = true
        return spinner
    }()
    
    lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "cloudy-weather")
        return image
    }()
    
    lazy var weatherDescription: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
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
    
    lazy var refreshButton: UIButton = {
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
    
    lazy var dateLabel: UILabel = {
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
    
    lazy var pressureLabel: UILabel = {
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
    
    lazy var humidityLabel: UILabel = {
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
    
    lazy var windLabel: UILabel = {
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
    
    //MARK: - CollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views
    private func setupViews() {
        addSubview(collectionView)
        addSubview(weatherImage)
        addSubview(weatherDescription)
        addSubview(temperatureLabel)
        addSubview(cityLabel)
        addSubview(refreshButton)
        addSubview(dateLabel)
        addSubview(detailStackView)
        addSubview(weatherDataStackView)
        addSubview(visibilityStackView)
        addSubview(humidityStackView)
        addSubview(winddStackView)
        addSubview(sevenDaysForecast)
        addSubview(todayLabel)
        addSubview(spinner)
        addSubview(windName)
        addSubview(windImage)
        addSubview(windLabel)
        addSubview(winddStackView)
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
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            
            refreshButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 46),
            refreshButton.widthAnchor.constraint(equalToConstant: 46),
            refreshButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            weatherDescription.heightAnchor.constraint(equalToConstant: 30),
            weatherDataStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
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
            
            detailStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            detailStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            detailStackView.heightAnchor.constraint(equalToConstant: 100),
            detailStackView.topAnchor.constraint(equalTo: weatherDataStackView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            sevenDaysForecast.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sevenDaysForecast.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 10),
            
            todayLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            todayLabel.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 10),
            
            collectionView.topAnchor.constraint(equalTo: sevenDaysForecast.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
