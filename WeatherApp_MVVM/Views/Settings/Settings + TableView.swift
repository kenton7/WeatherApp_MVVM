//
//  Settings + TableView.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation
import UIKit

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - setupTableView
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        tableView.rowHeight = 60
        registerCell()
    }
    
    //MARK: - reloadTableView
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - registerCell
    func registerCell() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.cellID)
    }
    
    //MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.numberOfRows(section)
    }
    
    //MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsViewModel.numberOfSections()
    }
    
    //MARK: - willDisplayHeaderView
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    //MARK: - titleForHeaderInSection
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsViewModel.titlesForSections(section)
    }
    
    //MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.cellID, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.setupCell(indexPath: indexPath)
            return cell
        } else {
            let cell = OtherMeasurementsCell(style: .default, reuseIdentifier: OtherMeasurementsCell.cellID)
            cell.setupOtherMeasurementsCell(indexPath: indexPath)
            return cell
        }
    }
    
    //MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsViewModel.didSelectRowAt(indexPath: indexPath, completion: reloadTableView)
    }
}
