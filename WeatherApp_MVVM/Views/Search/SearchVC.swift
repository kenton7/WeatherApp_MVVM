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
    
    private lazy var locationButton: UIButton = {
       let button = UIButton()
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1).cgColor
        button.layer.borderColor = UIColor.green.cgColor
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(locationButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    lazy var spinner: CustomSpinner = {
        let spinner = CustomSpinner(squareLength: 100)
        spinner.isHidden = true
        return spinner
    }()
    

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
        
                
        setupViews()
        setConstraints()
        setupTableView()
        setupSearchBar()
        bindViewModel()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
    @objc private func locationButtonPressed() {
        viewModel.isLoading.value = true
        viewModel.locationButtonPressed(longitude: coordinates?.longitude ?? 0.0, latitude: coordinates?.latitude ?? 0.0)
    }
    
    private func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                isLoading ? self.spinner.startAnimation(delay: 0.0, replicates: 20) : self.spinner.stopAnimation()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] data in
            guard let self, let data = data else { return }
            realmDataSource = data
            reloadTableView() 
        }
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(red: 0.11, green: 0.16, blue: 0.22, alpha: 1)
        view.addSubview(locationButton)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(spinner)
    }

}

extension SearchVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: 55),
            locationButton.heightAnchor.constraint(equalToConstant: 55),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            searchBar.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: locationButton.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
