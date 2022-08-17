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
        tabBarController.tabBar.tintColor = Color.black
        tabBarController.tabBar.unselectedItemTintColor = Color.lightGrey
        tabBarController.tabBar.backgroundColor = Color.white
        tabBarController.viewControllers = getViewControllers()

        return tabBarController
    }

    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = createViewController(type: tab)
            let tabBarItem = UITabBarItem(title: tab.properties.title,
                                          image: tab.properties.image,
                                          selectedImage: tab.properties.selectedImage)
            controller.tabBarItem = tabBarItem
            
            let navigationController = addNavigationController(for: controller)
            viewControllers.append(navigationController)
        }

        return viewControllers
    }

    func createViewController(type: TabBarModel) -> UIViewController {
        switch type {
        case .main:
            return ModuleBuilder.createMainModule()
        case .favorite:
            return ModuleBuilder.createFavoriteModule()
        case .profile:
            return ProfileViewController()
        }
    }
    
    func addNavigationController(for viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = Color.black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: Color.black,
                                                                  .font: UIFont.systemFont(ofSize: 17,
                                                                                           weight: .semibold)]
        return navigationController
    }

}
