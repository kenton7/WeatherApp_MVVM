//
//  ForecastCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import UIKit

class ForecastCoordinator: Coordinator {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func start() {
        
        let serviceLocator = ServiceLocator.shared
        
        let weatherImageService: IGetWeatherImage! = serviceLocator.getService()
        let calculateMeasurementsService: ICalculateMeasurements! = serviceLocator.getService()
        
        let vc = ForecastVC(latitude: latitude, longitude: longitude, calculateMeasurementsService: calculateMeasurementsService, weatherImagesService: weatherImageService)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
