//
//  SettingsTableViewCell.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let cellID = "SettingsTableViewCell"
    
    let temperatureLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 15
        backgroundColor = .backgroundColorTabBar
        addSubview(temperatureLabel)
        selectionStyle = .none
        tintColor = .white
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(indexPath: IndexPath) {
        temperatureLabel.text = MeasureType.allCases[indexPath.row].rawValue
    }
    
}
