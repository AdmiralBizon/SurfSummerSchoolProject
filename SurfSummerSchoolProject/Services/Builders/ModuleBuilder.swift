//
//  ModuleBuilder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import UIKit

final class ModuleBuilder: Builder {
    
    static let dataStore = DataStore.shared
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, dataStore: dataStore)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(item: DetailItemModel?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, item: item)
        view.presenter = presenter
        return view
    }
    
    static func createSearchModule(items: [DetailItemModel], delegate: BaseViewDelegate?) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view,
                                        dataStore: dataStore,
                                        items: items,
                                        delegate: delegate)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoritesViewController()
        let favoritesService = FavoritesService()
        let presenter = FavoritesPresenter(view: view,
                                           favoritesService: favoritesService)
        view.presenter = presenter
        return view
    }
    
}
