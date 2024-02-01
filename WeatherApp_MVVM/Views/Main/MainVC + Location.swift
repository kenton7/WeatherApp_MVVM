//
//  MainVC + Location.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import Foundation
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {

    //MARK: - didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error trying to get user's location \(error.localizedDescription)")
    }
    
    //MARK: - didChangeAuthorization
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    //MARK: - didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.mainScreenViews.spinner.isHidden = false
        viewModel.getCurrentWeather(longitude: locValue.longitude, latitude: locValue.latitude)
        viewModel.getForecast(longitude: locValue.longitude, latitude: locValue.latitude)
        manager.stopUpdatingLocation()
    }
}
