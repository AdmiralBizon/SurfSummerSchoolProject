//
//  ModuleBuilder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import UIKit

final class ModuleBuilder: Builder {
    
    static var mainModuleDelegate: MainViewPresenterProtocol? = nil
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, dataStore: DataStore.shared)
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
                                        delegate: delegate,
                                        mainScreenDelegate: mainScreenDelegate)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter(view: view,
                                           dataStore: DataStore.shared,
                                           delegate: mainModuleDelegate)
        view.presenter = presenter
        return view
    }
    
}
