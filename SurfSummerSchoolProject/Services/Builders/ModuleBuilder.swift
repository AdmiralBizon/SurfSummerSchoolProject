//
//  ModuleBuilder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import UIKit

struct ModuleBuilder: Builder {
    
    static var mainModuleDelegate: MainViewPresenterProtocol? = nil
    static var dataStore: DataStore? = nil
    
    static func prepareForStartMainFlow() {
        mainModuleDelegate = nil
        dataStore = DataStore()
    }
    
    static func prepateForEndMainFlow() {
        mainModuleDelegate = nil
        dataStore = nil
    }
    
    static func createAuthModule() -> UIViewController {
        let view = AuthViewController()
        let authService = AuthService()
        let presenter = AuthPresenter(view: view, authService: authService)
        view.presenter = presenter
        return view
    }
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, dataStore: dataStore)
        view.presenter = presenter
        
        mainModuleDelegate = presenter
        
        return view
    }
    
    static func createDetailModule(item: DetailItemModel?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, item: item)
        view.presenter = presenter
        return view
    }
    
    static func createSearchModule(items: [DetailItemModel], delegate: BasePresenterDelegate?, useMainModuleDelegate: Bool) -> UIViewController
        {
        
        let mainScreenDelegate = useMainModuleDelegate ? mainModuleDelegate : nil
        
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view,
                                        items: items,
                                        dataStore: dataStore,
                                        delegate: delegate,
                                        mainScreenDelegate: mainScreenDelegate)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter(view: view,
                                           dataStore: dataStore,
                                           delegate: mainModuleDelegate)
        view.presenter = presenter
        return view
    }
    
    static func createProfileModule() -> UIViewController {
        var userInfo: User? = nil
    
        if let userPhone = try? UserCredentialsManager.shared.getCredentials().login,
           let savedInfo = CoreDataManager.shared.searchUser(key: "phone", value: userPhone) {
            userInfo = savedInfo
        }
        
        let view = ProfileViewController()
        let authService = AuthService()
        let presenter = ProfilePresenter(view: view, user: userInfo, authService: authService)
        view.presenter = presenter
        return view
    }
    
}
