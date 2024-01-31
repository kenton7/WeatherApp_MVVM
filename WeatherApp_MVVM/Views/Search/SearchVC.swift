//
//  SearchVC.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit
import RealmSwift
import CoreLocation

final class SearchVC: UIViewController {
    
    let locationManager = CLLocationManager()
    var coordinates: Coordinates?
    var realmDataSource = [SearchCellViewModel]()
    var viewModel = SearchVCViewModel()
    private lazy var realm = try! Realm()
    let searchScreenViews = SearchScreenViews()
    
    override func loadView() {
        super.loadView()
        view = searchScreenViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setupLocation()
        viewModel.forecastRealm = self.realm.objects(ForecastRealm.self)
        
        setupTableView()
        setupSearchBar()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocation()
    }
    
    //MARK: - Location button pressed method
    @objc func locationButtonPressed(sender: UIButton) {
        viewModel.locationButtonPressed(longitude: coordinates?.longitude ?? 0.0, latitude: coordinates?.latitude ?? 0.0)
    }
    
    //MARK: - Binding
    private func bindViewModel() {
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            realmDataSource = data
            reloadTableView() 
        }
    }
}


