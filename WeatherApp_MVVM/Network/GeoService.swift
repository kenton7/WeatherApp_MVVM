//
//  GeoService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation

class GeoService {
    private let client: RestApiClient
    //private let currentWeatherService: CurrentWeatherFetch
    
    init(client: RestApiClient = .init()/*, currentWeatherService: CurrentWeatherFetch = .init()*/ ) {
        self.client = client
        //self.currentWeatherService = currentWeatherService
    }
    
    func searchCity(_ city: String, completion: @escaping (Result<Geocoding, Error>) -> Void) {
        
        client.performRequest(WeatherEndpoints.geo(city: city)) { result in
            switch result {
            case .success(let geoData):
                do {
                    let city = try JSONDecoder().decode(Geocoding.self, from: geoData)
                    completion(.success(city))
                }
                catch let error {
                    print("error when parsing city JSON:: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("error searching city: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func weatherByGeo(city: String, completion: @escaping (Result<Geocoding, Error>) -> Void,
                      handler: @escaping (Result<CurrentWeatherModel, Error>) -> Void) {
        UserDefaults.standard.set(city, forKey: "city")
        client.performRequest(WeatherEndpoints.geo(city: city)) { result in
            switch result {
            case .success(let data):
                let city = try! JSONDecoder().decode(Geocoding.self, from: data)
                completion(.success(city))
                self.client.performRequest(WeatherEndpoints.currentWeather(latitude: city.first?.lat ?? 0.0, longitude: city.first!.lon ?? 0.0, units: UserDefaults.standard.string(forKey: "units") ?? "metric", lang: Language.ru)) { currentWeatherResult in
                    switch currentWeatherResult {
                    case .success(let data):
                        let currentWeather = try! JSONDecoder().decode(CurrentWeatherModel.self, from: data)
                        handler(.success(currentWeather))
                    case .failure(let error):
                        print("error when get current weather after searching city: \(error.localizedDescription)")
                        handler(.failure(error))
                    }
                }
            case .failure(let error):
                print("error when get city: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
    }
}
