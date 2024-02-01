//
//  RealmDeleteService.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 30.01.2024.
//

import Foundation
import RealmSwift

protocol IRealmDelete {
    func deleteFromRealm(data: ForecastRealm, completion: @escaping () -> Void)
}

class RealmDeleteService: IRealmDelete {
    
    static let shared = RealmDeleteService()
    private init() {}
    lazy var realm = try! Realm()
    
    func deleteFromRealm(data: ForecastRealm, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.delete(data)
                }
                completion()
            } catch let error {
                print("error when trying to delete data from Realm: \(error.localizedDescription)")
            }
        }
    }
}
