//
//  MainCollectionViewCellViewModel.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit.UIImage
import Foundation

final class MainCollectionViewCellViewModel {
    var time: String
    var image: UIImage
    var temperature: String
    
    init?(_ data: List, weatherImageService: IGetWeatherImage) {
        guard let weather = data.weather?.first else { return nil }
        let date = data.dateString?.components(separatedBy: "-")
        let separatedDate = String(date?[2].components(separatedBy: " ").dropFirst().joined().prefix(5) ?? "")
        self.time = separatedDate
        self.image = weatherImageService.weatherImages(id: weather.id ?? 803, pod: String(weather.icon?.last ?? "d"))
        self.temperature = "\(Int(data.main?.temp?.rounded() ?? 0))"
    }
}
