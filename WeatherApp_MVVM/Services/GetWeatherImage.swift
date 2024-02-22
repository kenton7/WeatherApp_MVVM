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
        
        guard let cloudyWeather = UIImage(named: "cloudy-weather"),
              let nightStorm = UIImage(named: "night-storm"),
              let storm = UIImage(named: "storm"),
              let nightCloudsSun = UIImage(named: "night-clouds-sun"),
              let rain = UIImage(named: "rain"),
              let nightRain = UIImage(named: "night-rain"),
              let nightSnow = UIImage(named: "night-snow"),
              let snow = UIImage(named: "snow"),
              let nightFoggy = UIImage(named: "night-foggy"),
              let foggy = UIImage(named: "foggy"),
              let nightMoon = UIImage(named: "night-moon"),
              let sun = UIImage(named: "sun"),
              let nightCloudy = UIImage(named: "night-cloudy"),
              let nightCloudy2 = UIImage(named: "night-cloudy2"),
              let cloudy = UIImage(named: "cloudy") else {
            return UIImage()
        }
              
        
        guard let pod else {
            print("Не удалось определить картинку погоды по pod \(String(describing: pod))")
            return cloudyWeather
        }
        switch id {
        case 200...232:
            if pod == "n" {
                return nightStorm
            } else {
                return storm
            }
        case 300...321:
            if pod == "n" {
                return nightCloudsSun
            } else {
                return rain
            }
        case 500...531:
            if pod == "n" {
                return nightRain
            } else {
                return rain
            }
        case 600...622:
            if pod == "n" {
                return nightSnow
            } else {
                return snow
            }
        case 700...781:
            if pod == "n" {
                return nightFoggy
            } else {
                return foggy
            }
        case 800:
            if pod == "n" {
                return nightMoon
            } else {
                return sun
            }
        case 801:
            if pod == "n" {
                return nightCloudy
            } else {
                return cloudyWeather
            }
        case 802:
            if pod == "n" {
                return nightCloudy2
            } else {
                return cloudy
            }
        case 803:
            if pod == "n" {
                return nightCloudy
            } else {
                return cloudyWeather
            }
        case 804:
            if pod == "n" {
                return nightCloudy2
            } else {
                return cloudy
            }
        default:
            return cloudyWeather
        }
    }
}
