//
//  OtherMeasurementsCell.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import UIKit

final class OtherMeasurementsCell: UITableViewCell {
    
    static let cellID = "OtherMeasurementsCell"
    
    private lazy var parameterLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var segmentedControlForWind: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            MeasurementsTypes.metersPerSecond.rawValue,
            MeasurementsTypes.kilometerPerHour.rawValue,
            MeasurementsTypes.milesPerHour.rawValue
        ])
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "windIndex")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        segmentedControl.addTarget(self, action: #selector(SettingsVC.windSegmentedControlPressed(segment:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private var segmetedControlForPressure: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            MeasurementsTypes.mmRtSt.rawValue,
            MeasurementsTypes.hPa.rawValue,
            MeasurementsTypes.dRtSt.rawValue
        ])
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "pressureIndex")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        segmentedControl.addTarget(self, action: #selector(SettingsVC.pressureSegmentedPressed(segment:)), for: .valueChanged)
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 15
        backgroundColor = .backgroundColorTabBar
        selectionStyle = .none
        tintColor = .white
        contentView.isUserInteractionEnabled = false
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views
    private func setupViews() {
        addSubview(parameterLabel)
        addSubview(segmentedControlForWind)
        addSubview(segmetedControlForPressure)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            parameterLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            parameterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            parameterLabel.heightAnchor.constraint(equalToConstant: 30),
            parameterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            segmentedControlForWind.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            segmentedControlForWind.centerYAnchor.constraint(equalTo: centerYAnchor),
            segmentedControlForWind.widthAnchor.constraint(equalTo: segmetedControlForPressure.widthAnchor),
            
            segmetedControlForPressure.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            segmetedControlForPressure.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    //MARK: - Setup cell
    func setupOtherMeasurementsCell(indexPath: IndexPath) {
        parameterLabel.text = MeasureType.allCases[indexPath.row + 2].rawValue
        
        if indexPath.row == 0 {
            segmetedControlForPressure.isHidden = true
            if let value = UserDefaults.standard.value(forKey: "windIndex") {
                let selectedIndex = value as! Int
                segmentedControlForWind.selectedSegmentIndex = selectedIndex
            }
        } else {
            segmentedControlForWind.isHidden = true
            if let value = UserDefaults.standard.value(forKey: "pressureIndex") {
                let selectedIndex = value as! Int
                segmetedControlForPressure.selectedSegmentIndex = selectedIndex
            }
        }
        accessoryType = .none
    }
}
