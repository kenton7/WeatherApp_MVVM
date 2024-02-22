//
//  GetWeatherImage.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit
import Foundation

protocol IGetWeatherImage {
    func weatherImages(id: Int, pod: String?) -> UIImage
}

final class GetWeatherImage: IGetWeatherImage {
    
    /// Функция для автоматического выбора картинки погоды, на основе ID погоды, приходящей с сервера
    /// - Parameters:
    ///   - id: ID погоды с сервера
    ///   - pod: символ "d" (day) или "n" (night). Выбирается либо дневная картинка, либо ночная
    /// - Returns: Возвращает полученную картинку
    func weatherImages(id: Int, pod: String?) -> UIImage {
        
        guard let pod else {
            print("Не удалось определить картинку погоды по pod \(String(describing: pod))")
            return Images.cloudyWeather
        }
        switch id {
        case 200...232:
            if pod == "n" {
                return Images.nightStorm
            } else {
                return Images.storm
            }
        case 300...321:
            if pod == "n" {
                return Images.nightCloudsSun
            } else {
                return Images.rain
            }
        case 500...531:
            if pod == "n" {
                return Images.nightRain
            } else {
                return Images.rain
            }
        case 600...622:
            if pod == "n" {
                return Images.nightSnow
            } else {
                return Images.snow
            }
        case 700...781:
            if pod == "n" {
                return Images.nightFoggy
            } else {
                return Images.foggy
            }
        case 800:
            if pod == "n" {
                return Images.nightMoon
            } else {
                return Images.sun
            }
        case 801:
            if pod == "n" {
                return Images.nightCloudy
            } else {
                return Images.cloudyWeather
            }
        case 802:
            if pod == "n" {
                return Images.nightCloudy2
            } else {
                return Images.cloudy
            }
        case 803:
            if pod == "n" {
                return Images.nightCloudy
            } else {
                return Images.cloudyWeather
            }
        case 804:
            if pod == "n" {
                return Images.nightCloudy2
            } else {
                return Images.cloudy
            }
        default:
            return Images.cloudyWeather
        }
    }
}
