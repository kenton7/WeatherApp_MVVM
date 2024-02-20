//
//  SearchCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import Foundation

class SearchCoordinator: Coordinator {
    
    override func start() {
        let serviceLocator: IServiceLocator = {
            let serviceLocator = ServiceLocator.shared
            serviceLocator.addService(service: RealmUpdateDataService.shared as IRealmUpdateService)
            serviceLocator.addService(service: RealmSaveService.shared as IRealmSaveService)
            serviceLocator.addService(service: RealmDeleteService.shared as IRealmDelete)
            return serviceLocator
        }()
        
        let weatherImageService: IGetWeatherImage! = serviceLocator.getService()
        let realmUpdateService: IRealmUpdateService! = serviceLocator.getService()
        let realmDeleteService: IRealmDelete! = serviceLocator.getService()
        let realmSaverService: IRealmSaveService! = serviceLocator.getService()
        let searchViewModel = SearchVCViewModel(realmUpdateDataService: realmUpdateService, realmSaveService: realmSaverService, realmDeleteService: realmDeleteService)
        let vc = SearchVC(weatherImageService: weatherImageService, realmUpdateService: nil, realmSaverService: nil, realmDeleteService: nil, searchViewModel: searchViewModel)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
