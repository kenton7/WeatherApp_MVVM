//
//  CurrentWeatherFetch.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

protocol ICurrentWeatherService {
    func getCurrentWeather(longitude: Double,
                           latitude: Double,
                           units: String,
                           language: Language,
                           completion: @escaping (Result<CurrentWeatherModel, Error>) -> Void)
}

final class CurrentWeatherFetch: ICurrentWeatherService {
    
    private let client: RestApiClient
    
    init(client: RestApiClient = .init() ) {
        self.client = client
    }
    
    func getCurrentWeather(longitude: Double, 
                           latitude: Double,
                           units: String,
                           language: Language,
                           completion: @escaping (Result<CurrentWeatherModel, Error>) -> Void) {
                
        client.performRequest(WeatherEndpoints.currentWeather(latitude: latitude, 
                                                              longitude: longitude,
                                                              units: units,
                                                              lang: language)) { result in
            switch result {
            case .success(let data):
                do {
                    let weather = try JSONDecoderHelper.getDecoder().decode(CurrentWeatherModel.self, from: data)
                    completion(.success(weather))
                } catch let error {
                    print("can't parse current weather: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("can't get current weather: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
