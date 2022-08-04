//
//  TabBarConfigurator.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import Foundation
import UIKit

final class TabBarConfigurator {

    // MARK: - Private property
    private let allTab: [TabBarModel] = [.main, .favorite, .profile]

    // MARK: - Internal Methods
    func configure() -> UITabBarController {
        getTabBarController()
    }

}

// MARK: - Private Methods
private extension TabBarConfigurator {

    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getViewControllers()

        return tabBarController
    }

    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()

        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            
            let navigationController = addNavigationController(for: controller)
            viewControllers.append(navigationController)
        }

        return viewControllers
    }

    func getCurrentViewController(tab: TabBarModel) -> UIViewController {
        switch tab {
        case .main:
            return MainViewController()
        case .favorite:
            return FavoriteViewController()
        case .profile:
            return ProfileViewController()
        }
    }
    
    func addNavigationController(for viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                  .font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        return navigationController
    }

}