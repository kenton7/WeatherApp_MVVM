//
//  MainCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import Foundation

class MainCoordinator: Coordinator {
    
    let serviceLocator = ServiceLocator.shared
    
    override func start() {
        
        serviceLocator.addService(service: CalculateMeasurements() as ICalculateMeasurements)
        serviceLocator.addService(service: GetWeatherImage() as IGetWeatherImage)
        
        guard let weatherImageService: IGetWeatherImage = serviceLocator.getService(),
              let calculateMeasurementsService: ICalculateMeasurements = serviceLocator.getService() else { return }
        let vc = MainViewController(weatherImageService: weatherImageService, calculateMeasurementsService: calculateMeasurementsService)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
