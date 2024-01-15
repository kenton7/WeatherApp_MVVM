//
//  AbstractFactory.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 14.01.2024.
//

import Foundation
import UIKit

protocol ViewControllerFactory {
    func makeForecastViewController() -> UIViewController
}

struct ForecastViewControllerFactory: ViewControllerFactory {
    func makeForecastViewController() -> UIViewController {
        return ForecastVC()
    }
}
