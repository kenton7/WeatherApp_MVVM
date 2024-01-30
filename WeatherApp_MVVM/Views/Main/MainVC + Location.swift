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
//            DispatchQueue.main.async {
//                self.mainScreenViews.spinner.isHidden = false
//                self.mainScreenViews.spinner.startAnimation(delay: 0.0, replicates: 20)
//            }
        }
    }
    
    //MARK: - didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print(locValue.latitude, locValue.longitude)
        let coordinates = Coordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        do {
            let encodedCoordinates = try JSONEncoder().encode(coordinates)
            UserDefaults.standard.set(encodedCoordinates, forKey: "coordinates")
        } catch {
            print("Error encoding coordinates: \(error)")
        }
        self.mainScreenViews.spinner.isHidden = false
        viewModel.getCurrentWeather(longitude: locValue.longitude, latitude: locValue.latitude)
        viewModel.getForecast(longitude: locValue.longitude, latitude: locValue.latitude)
        manager.stopUpdatingLocation()
    }
}
