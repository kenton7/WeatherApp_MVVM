//
//  SettingsVC.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit

final class SettingsVC: UIViewController {
    
    let settingsViewModel = SettingsVCViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstraints()
        setupTableView()
    }
    
    @objc func windSegmentedControlPressed(segment: UISegmentedControl) {
        let selectedParameter = segment.titleForSegment(at: segment.selectedSegmentIndex)
        UserDefaults.standard.set(selectedParameter, forKey: MeasurementsTypes.wind.rawValue)
        UserDefaults.standard.set(segment.selectedSegmentIndex, forKey: "windIndex")
    }
    
    @objc func pressureSegmentedPressed(segment: UISegmentedControl) {
        let selectedParameter = segment.titleForSegment(at: segment.selectedSegmentIndex)
        UserDefaults.standard.set(selectedParameter, forKey: MeasurementsTypes.pressure.rawValue)
        UserDefaults.standard.set(segment.selectedSegmentIndex, forKey: "pressureIndex")
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = UIColor(red: 0.11, green: 0.16, blue: 0.22, alpha: 1)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
