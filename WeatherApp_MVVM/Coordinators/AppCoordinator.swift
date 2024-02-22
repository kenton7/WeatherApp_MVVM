//
//  AppCoordinator.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 01.02.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    override func start() {
        showMainFlow()
    }
    
    override func finish() {
        print("AppCoordinator finished")
    }
}

//MARK: - Navigation methods
private extension AppCoordinator {
    
    func showMainFlow() {
        guard let navigationController = navigationController else { return }
        
        let mainNavigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(type: .main, navigationController: mainNavigationController)
        mainNavigationController.tabBarItem = UITabBarItem.houseFill
        mainCoordinator.coordinatorFinishDelegate = self
        mainCoordinator.start()
        
        let searchNavigationController = UINavigationController()
        let searchCoordinator = SearchCoordinator(type: .search, navigationController: searchNavigationController)
        searchNavigationController.tabBarItem = UITabBarItem.magnifyingGlass
        searchCoordinator.coordinatorFinishDelegate = self
        searchCoordinator.start()
        
        let settingsNavigationController = UINavigationController()
        let settingsCoordinator = SettingsCoordinator(type: .search, navigationController: settingsNavigationController)
        settingsNavigationController.tabBarItem = UITabBarItem.gear
        settingsCoordinator.coordinatorFinishDelegate = self
        settingsCoordinator.start()
        
        addChildCoordinator(mainCoordinator)
        addChildCoordinator(searchCoordinator)
        addChildCoordinator(settingsCoordinator)
        
        let tabBarControllers = [mainNavigationController, searchNavigationController, settingsNavigationController]
        let tabBarController = TabBarController(tabBarControllers: tabBarControllers)
        navigationController.pushViewController(tabBarController, animated: true)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorFinish(childCoordinator: ICoordinator) {
        removeChildCoordinator(childCoordinator)
        
        switch childCoordinator.type {
        case .main:
            return
        default:
            navigationController?.popViewController(animated: false)
        }
    }
}
