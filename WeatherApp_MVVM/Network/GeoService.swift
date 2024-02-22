//
//  GeoService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 12.01.2024.
//

import Foundation

protocol IGeoService {
    func searchCity(_ city: String, completion: @escaping (Result<Geocoding, Error>) -> Void)
}

final class GeoService: IGeoService {
    
    private let client: RestApiClient
    
    init(client: RestApiClient = .init() ) {
        self.client = client
    }
    
    func searchCity(_ city: String, completion: @escaping (Result<Geocoding, Error>) -> Void) {
        client.performRequest(WeatherEndpoints.geo(city: city)) { result in
            switch result {
            case .success(let geoData):
                do {
                    let city = try JSONDecoderHelper.getDecoder().decode(Geocoding.self, from: geoData)
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
}
