//
//  ForecastCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 02.02.2024.
//

import UIKit

class ForecastCoordinator: Coordinator {
    
    var latitude = 0.0
    var longitude = 0.0
    let serviceLocator = ServiceLocator.shared
    
    override func start() {

        guard let weatherImageService: IGetWeatherImage = serviceLocator.getService(),
              let calculateMeasurementsService: ICalculateMeasurements = serviceLocator.getService() else {
            return
        }
        
        let vc = ForecastVC(latitude: latitude, longitude: longitude, calculateMeasurementsService: calculateMeasurementsService, weatherImagesService: weatherImageService)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}
