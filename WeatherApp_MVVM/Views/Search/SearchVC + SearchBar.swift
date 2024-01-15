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
        searchBar.searchTextField.autocorrectionType = .yes
        UserDefaults.standard.set(searchingCity, forKey: "city")
        
        viewModel.searchCity(city: searchingCity)
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
