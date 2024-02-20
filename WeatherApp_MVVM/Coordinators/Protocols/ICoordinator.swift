//
//  Coordnator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 01.02.2024.
//

import Foundation
import UIKit

enum CoordinatorTypes {
    case main
    case search
    case settings
    case forecast
}

protocol ICoordinator: AnyObject {
    var childCoordinators: [ICoordinator] { get set }
    var type: CoordinatorTypes { get }
    var navigationController: UINavigationController? { get set }
    var coordinatorFinishDelegate: CoordinatorFinishDelegate? { get set }
    func start()
    func finish()
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorFinish(childCoordinator: ICoordinator)
}

extension ICoordinator {
    func addChildCoordinator(_ childCoordinator: ICoordinator) {
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: ICoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

//MARK: - TabBarCoordinator
protocol TabBarCoordinator: AnyObject, ICoordinator {
    var tabBarController: UITabBarController? { get set }
}

class Coordinator: ICoordinator {
    var childCoordinators: [ICoordinator]
    
    var type: CoordinatorTypes
    
    var navigationController: UINavigationController?
    
    var coordinatorFinishDelegate: CoordinatorFinishDelegate?
    
    init(childCoordinators: [ICoordinator] = [ICoordinator](), type: CoordinatorTypes, navigationController: UINavigationController, coordinatorFinishDelegate: CoordinatorFinishDelegate? = nil) {
        self.childCoordinators = childCoordinators
        self.type = type
        self.navigationController = navigationController
        self.coordinatorFinishDelegate = coordinatorFinishDelegate
    }
    
    deinit {
        print("Coordinator deinited \(type)")
        childCoordinators.forEach { $0.coordinatorFinishDelegate = nil }
        childCoordinators.removeAll()
    }
    
    func start() {
        print("Coordinator start")
    }
    
    func finish() {
        print("Coordinator finish")
    }
}
