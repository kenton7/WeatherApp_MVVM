//
//  SettingsCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import Foundation

class SettingsCoordinator: Coordinator {
    
    override func start() {

        let serviceLocator: IServiceLocator = {
            let serviceLocator = ServiceLocator.shared
            serviceLocator.addService(service: DefaultsSaverService.shared as IDefaultSaverService)
            serviceLocator.addService(service: DefaultsGetterDataService.shared as IDefaultsGetterData)
            return serviceLocator
        }()
        
        let defaultsSaverService: IDefaultSaverService! = serviceLocator.getService()
        let defaultsGetterService: IDefaultsGetterData! = serviceLocator.getService()
        
        let settingsViewModel = SettingsVCViewModel()
        let vc = SettingsVC(defaultsGetterService: defaultsGetterService,
                            defaultsSaverDervice: defaultsSaverService,
                            settingsViewModel: settingsViewModel)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
