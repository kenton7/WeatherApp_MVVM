//
//  SearchScreenViews.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 25.01.2024.
//

import UIKit

class SearchScreenViews: UIView {

    private var locationButton: UIButton = {
       let button = UIButton()
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor(red: 0.322, green: 0.239, blue: 0.498, alpha: 1).cgColor
        button.layer.borderColor = UIColor.green.cgColor
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(SearchVC.locationButtonPressed(sender:)), for: .touchUpInside)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup views
    private func setupViews() {
        backgroundColor = UIColor(red: 0.11, green: 0.16, blue: 0.22, alpha: 1)
        addSubview(locationButton)
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(spinner)
    }
    
    //MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            locationButton.widthAnchor.constraint(equalToConstant: 55),
            locationButton.heightAnchor.constraint(equalToConstant: 55),
            locationButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            locationButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            searchBar.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: locationButton.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
