//
//  ModuleBuilder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(item: DetailItemModel?) -> UIViewController
    static func createSearchModule(items: [DetailItemModel]) -> UIViewController
    static func createFavoriteModule() -> UIViewController
}

final class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let picturesService = PicturesService()
        let favoritesService = FavoritesService()
        let presenter = MainPresenter(view: view,
                                      networkService: picturesService,
                                      favoritesService: favoritesService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(item: DetailItemModel?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, item: item)
        view.presenter = presenter
        return view
    }
    
    static func createSearchModule(items: [DetailItemModel]) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view, items: items)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoriteViewController()
        let favoritesService = FavoritesService()
        let presenter = FavoritePresenter(view: view,
                                          favoritesService: favoritesService)
        view.presenter = presenter
        return view
    }
    
}
