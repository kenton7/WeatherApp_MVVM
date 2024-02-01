//
//  ForecastVC + TableView.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation
import UIKit

extension ForecastVC: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - setupTableView
    func setupTableView() {
        forecastScreenViews.tableView.delegate = self
        forecastScreenViews.tableView.dataSource = self
        forecastScreenViews.tableView.translatesAutoresizingMaskIntoConstraints = false
        forecastScreenViews.tableView.showsVerticalScrollIndicator = false
        forecastScreenViews.tableView.separatorColor = .clear
        forecastScreenViews.tableView.backgroundColor = .clear
        registerCell()
    }
    
    //MARK: - registerCell
    func registerCell() {
        forecastScreenViews.tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.cellID)
    }
    
    //MARK: - reloadTableView
    func reloadTableView() {
        DispatchQueue.main.async {
            self.forecastScreenViews.tableView.reloadData()
        }
    }
    
    //MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section)
    }
    
    //MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    //MARK: - heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //MARK: - cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.cellID, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.forecastData[indexPath.section]
        cell.setupCell(cellViewModel)
        return cell
    }
}
