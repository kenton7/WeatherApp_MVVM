//
//  TabBarController.swift
//  WeatherApp_MVVM
//
//  Created by Илья Кузнецов on 11.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    private let tabBarView = TabBarView()
    
    init(tabBarControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        for tab in tabBarControllers {
            self.addChild(tab)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setValue(tabBarView, forKey: "tabBar")
        self.selectedIndex = 0
    }
}

//MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabBar = tabBar as? TabBarView {
            tabBar.updateCurveForTappedIndex()
        }
    }
}
