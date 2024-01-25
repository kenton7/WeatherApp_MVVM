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
        searchScreenViews.tableView.delegate = self
        searchScreenViews.tableView.dataSource = self
        searchScreenViews.tableView.translatesAutoresizingMaskIntoConstraints = false
        searchScreenViews.tableView.backgroundColor = .clear
        searchScreenViews.tableView.showsVerticalScrollIndicator = false
        searchScreenViews.tableView.separatorColor = .clear
        registerCell()
    }
    
    func registerCell() {
        searchScreenViews.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.cellID)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.searchScreenViews.tableView.reloadData()
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
        viewModel.updateWeatherIn(city: viewModel.forecastRealm[indexPath.section].cityName,
                                  indexPath: indexPath, completion: reloadTableView)
        let realmViewModelCell = viewModel.forecastRealm[indexPath.section]
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { UIContextualAction, _, completion in
            self.viewModel.deleteDataFromRealm(indexPath: indexPath)
            completion(true)
        }
        return viewModel.customDeleteButton(action: delete)
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell {
            cell.layer.cornerRadius = 15
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let factory: ViewControllerFactory = ForecastViewControllerFactory()
        let forecastVC = factory.makeForecastViewController() as! ForecastVC
        forecastVC.hidesBottomBarWhenPushed = false
        let transferData = viewModel.forecastRealm[indexPath.section]
        forecastVC.longitude = transferData.longitude
        forecastVC.latitude = transferData.latitude
        forecastVC.forecastScreenViews.weatherImage.image = GetWeatherImage.weatherImages(id: transferData.id, pod: transferData.dayOrNight)
//        viewModel.didSelectRow(indexPath: indexPath, data: viewModel.forecastRealm[indexPath.section])
        navigationController?.pushViewController(forecastVC, animated: true)
    }
}
