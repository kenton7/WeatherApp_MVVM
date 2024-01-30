//
//  MainViewController+CollectionView.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - setupCollectionView
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        mainScreenViews.collectionView.delegate = self
        mainScreenViews.collectionView.dataSource = self
        registerCell()
    }
    
    //MARK: - registerCell
    func registerCell() {
        mainScreenViews.collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.cellID)
    }
    
    //MARK: - reloadCollectionView
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.mainScreenViews.collectionView.reloadData()
        }
    }
    
    //MARK: - numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfitems()
    }
    
    //MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.cellID, for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
        let cellViewModel = cellDataSource[indexPath.item]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    //MARK: - sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 100)
    }
}
