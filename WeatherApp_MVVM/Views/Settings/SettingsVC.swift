//
//  SettingsVC.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit

final class SettingsVC: UIViewController {
    
    let settingsViewModel = SettingsVCViewModel()
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setupTableView()
    }
    
    //MARK: - Segmeted control pressing logic
    @objc func windSegmentedControlPressed(segment: UISegmentedControl) {
        let selectedParameter = segment.titleForSegment(at: segment.selectedSegmentIndex)
        DefaultsSaverService.shared.saveToUserDefaults(data: selectedParameter, key: MeasurementsTypes.wind.rawValue)
        DefaultsSaverService.shared.saveToUserDefaults(data: segment.selectedSegmentIndex, key: "windIndex")
    }
    
    @objc func pressureSegmentedPressed(segment: UISegmentedControl) {
        let selectedParameter = segment.titleForSegment(at: segment.selectedSegmentIndex)
        DefaultsSaverService.shared.saveToUserDefaults(data: selectedParameter, key: MeasurementsTypes.pressure.rawValue)
        DefaultsSaverService.shared.saveToUserDefaults(data: segment.selectedSegmentIndex, key: "pressureIndex")
    }
    
    //MARK: - Setup views
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 0.11, green: 0.16, blue: 0.22, alpha: 1)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
