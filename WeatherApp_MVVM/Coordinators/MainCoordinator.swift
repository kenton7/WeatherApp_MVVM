//
//  MainCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import Foundation

class MainCoordinator: Coordinator {
    
    override func start() {
        let serviceLocator: IServiceLocator = {
            let serviceLocator = ServiceLocator.shared
            serviceLocator.addService(service: CalculateMeasurements() as ICalculateMeasurements)
            serviceLocator.addService(service: GetWeatherImage() as IGetWeatherImage)
            return serviceLocator
        }()
        
        let weatherImageService: IGetWeatherImage! = serviceLocator.getService()
        let calculateMeasurementsService: ICalculateMeasurements! = serviceLocator.getService()
        let vc = MainViewController(weatherImageService: weatherImageService, calculateMeasurementsService: calculateMeasurementsService)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
