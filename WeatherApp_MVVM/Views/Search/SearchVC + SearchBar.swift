//
//  SearchVC + SearchBar.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation
import UIKit
import RealmSwift

extension SearchVC: UISearchBarDelegate {
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 15
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
        searchBar.barTintColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1)
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск города", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.rightView?.tintColor = .white
        searchBar.clipsToBounds = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchingCity = searchBar.text else { return }
        print(searchingCity)
        searchBar.searchTextField.autocorrectionType = .yes
        UserDefaults.standard.set(searchingCity, forKey: "city")
        
        viewModel.searchCity(city: searchingCity)
        searchBar.text = ""
        searchBar.endEditing(true)
        
        //        currentWeatherService.weatherByGeo(city: searchingCity) { [weak self] result in
        //            switch result {
        //            case .success(let city):
        //                guard let latitude = city.first?.lat, let longitude = city.first?.lon, let self = self else { return }
        //                self.currentWeatherService.getCurrentWeather(longitute: longitude, latitude: latitude, units: UserDefaults.standard.string(forKey: "units") ?? MeasurementsTypes.mertic.rawValue, language: Language.ru) { result in
        //                    switch result {
        //                    case .success(let currentWeather):
        //                        DispatchQueue.main.async {
        //                            try! self.realm.write({
        //                                self.realm.add(ForecastRealm(cityName: city.first!.localNames!["ru"]!,
        //                                                             dayOrNight: String(currentWeather.weather?.first?.icon?.last ?? "d"),
        //                                                             weatherDescription: currentWeather.weather?.first?.description ?? "",
        //                                                             id: currentWeather.weather?.first?.id ?? 803,
        //                                                             temp: currentWeather.main?.temp?.rounded() ?? 0.0,
        //                                                             latitude: latitude, longitude: longitude,
        //                                                             tempMin: currentWeather.main?.tempMin?.rounded() ?? 0.0,
        //                                                             tempMax: currentWeather.main?.tempMax?.rounded() ?? 0.0,
        //                                                             pressure: currentWeather.main?.pressure ?? 0,
        //                                                             humidity: currentWeather.main?.humidity ?? 0,
        //                                                             windSpeed: currentWeather.wind?.speed ?? 0,
        //                                                             selectedItem: 0,
        //                                                             date: "sds"))
        //                                self.uiElements.tableView.reloadData()
        //                                self.uiElements.spinner.isHidden = true
        //                            })
        //                            searchBar.text = ""
        //                            searchBar.endEditing(true)
        //                        }
        //                    case .failure(let error):
        //                        print(error)
        //                    }
        //                }
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        //    }
    }
}
