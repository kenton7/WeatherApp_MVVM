//
//  RealmSaveService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 30.01.2024.
//

import Foundation
import RealmSwift

protocol IRealmSaveService {
    func saveToDatabase(data: [ForecastRealm])
}

final class RealmSaveService: IRealmSaveService {
    
    static let shared = RealmSaveService()
    private init() {}
    lazy var realm = try! Realm()
    
    func saveToDatabase(data: [ForecastRealm]) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(data)
                }
            }
            catch let error {
                print("error when saving data in Realm: \(error.localizedDescription)")
            }
        }
    }
}
