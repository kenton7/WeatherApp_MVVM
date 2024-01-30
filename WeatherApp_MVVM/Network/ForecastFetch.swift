//
//  ForecastFetch.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation

protocol IForecastService {
    func getForecast(longitude: Double, 
                     latitude: Double,
                     units: String,
                     language: Language,
                     completion: @escaping (Result<ForecastModel, Error>) -> Void)
}

class ForecastFetch: IForecastService {
    
    private let client: RestApiClient
    
    init(client: RestApiClient = .init() ) {
        self.client = client
    }
    
    func getForecast(longitude: Double, 
                     latitude: Double,
                     units: String,
                     language: Language,
                     completion: @escaping (Result<ForecastModel, Error>) -> Void) {
        client.performRequest(WeatherEndpoints.forecast(latitude: latitude, longitude: longitude, units: units, lang: language)) { result in
            
            switch result {
            case .success(let data):
                let forecast = try! JSONDecoder().decode(ForecastModel.self, from: data)
                completion(.success(forecast))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
