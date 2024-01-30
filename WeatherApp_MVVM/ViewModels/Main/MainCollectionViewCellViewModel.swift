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
    
    init(_ data: List) {
        let date = data.dateString?.components(separatedBy: "-")
        let separatedDate = String(date?[2].components(separatedBy: " ").dropFirst().joined().prefix(5) ?? "")
        self.time = separatedDate
        self.image = GetWeatherImage.weatherImages(id: data.weather!.first?.id ?? 803, pod: String(data.weather!.first?.icon?.last ?? "d"))
        self.temperature = "\(Int(data.main?.temp?.rounded() ?? 0))"
    }
}
