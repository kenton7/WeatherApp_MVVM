//
//  SearchVC + TableView.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .clear
        registerCell()
    }
    
    func registerCell() {
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellID)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellID, for: indexPath) as? SearchTableViewCell else {return UITableViewCell() }
        viewModel.updateWeatherIn(city: viewModel.forecastRealm[indexPath.section].cityName, indexPath: indexPath)
        
        let realmViewModelCell = viewModel.forecastRealm[indexPath.section]
        print("realmViewModelCell \(realmViewModelCell.weatherDescription)")
        cell.setupCellNew(realmViewModelCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeader()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.isUserInteractionEnabled = false
        header.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooter()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        header.isUserInteractionEnabled = false
        header.backgroundColor = .clear
        header.clipsToBounds = false
        return header
    }
    
    
}
