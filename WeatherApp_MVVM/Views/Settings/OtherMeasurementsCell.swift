//
//  OtherMeasurementsCell.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import UIKit

class OtherMeasurementsCell: UITableViewCell {
    
    static let cellID = "OtherMeasurementsCell"
    
    let parameterLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let segmentedControlForWind: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            MeasurementsTypes.metersPerSecond.rawValue,
            MeasurementsTypes.kilometerPerHour.rawValue,
            MeasurementsTypes.milesPerHour.rawValue
        ])
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "windIndex")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        return segmentedControl
    }()
    
    let segmetedControlForPressure: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            MeasurementsTypes.mmRtSt.rawValue,
            MeasurementsTypes.hPa.rawValue,
            MeasurementsTypes.dRtSt.rawValue
        ])
        segmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "pressureIndex")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 15
        backgroundColor = .backgroundColorTabBar
        selectionStyle = .none
        tintColor = .white
        contentView.isUserInteractionEnabled = false // чтобы можно было нажать на segmeted control в ячейке
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(parameterLabel)
        addSubview(segmentedControlForWind)
        addSubview(segmetedControlForPressure)
    }
    
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
    
    func setupOtherMeasurementsCell(indexPath: IndexPath) {
        parameterLabel.text = MeasureType.allCases[indexPath.row + 2].rawValue
    }
    
}
