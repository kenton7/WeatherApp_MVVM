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
    var cellDataSource = [SearchCellViewModel]()
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

        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        viewModel.forecastRealm = self.realm.objects(ForecastRealm.self)
        
        setupTableView()
        setupSearchBar()
        bindViewModel()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
    @objc func locationButtonPressed(sender: UIButton) {
        viewModel.isLoading.value = true
        viewModel.locationButtonPressed(longitude: coordinates?.longitude ?? 0.0, latitude: coordinates?.latitude ?? 0.0)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.searchScreenViews.spinner.startAnimation(delay: 0.0, replicates: 20) : self.searchScreenViews.spinner.stopAnimation()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            realmDataSource = data
            reloadTableView() 
        }
    }
}
