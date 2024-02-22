//
//  SettingsCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import Foundation

class SettingsCoordinator: Coordinator {
    
    let serviceLocator = ServiceLocator.shared
    
    override func start() {
        serviceLocator.addService(service: DefaultsSaverService.shared as IDefaultSaverService)
        serviceLocator.addService(service: DefaultsGetterDataService.shared as IDefaultsGetterData)
        
        guard let defaultsSaverService: IDefaultSaverService = serviceLocator.getService(),
              let defaultsGetterService: IDefaultsGetterData = serviceLocator.getService() else {
            return
        }
        
        let settingsViewModel = SettingsVCViewModel()
        let vc = SettingsVC(defaultsGetterService: defaultsGetterService,
                            defaultsSaverService: defaultsSaverService,
                            settingsViewModel: settingsViewModel)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
