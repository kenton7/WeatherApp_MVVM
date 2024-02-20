//
//  ServiceLocator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 19.02.2024.
//

import Foundation

protocol IServiceLocator {
    func getService<T>() -> T?
}

final class ServiceLocator: IServiceLocator {
    
    private lazy var services: [String: Any] = [:]
    
    public static let shared = ServiceLocator()
    
    private init() {}

    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }

    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
