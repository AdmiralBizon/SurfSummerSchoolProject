//
//  FavoritePresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func showFavorites()
}

protocol FavoriteViewPresenterProtocol: AnyObject {
    init(view: FavoriteViewProtocol, favoritesService: FavoritesService)
    func loadFavorites()
    func saveFavorites()
    func removeFromFavorites(index: Int)
    var items: [DetailItemModel] { get set }
}

class FavoritePresenter: FavoriteViewPresenterProtocol {
    
    weak var view: FavoriteViewProtocol?
    let favoritesService: FavoritesService!
    var items: [DetailItemModel] = [] {
        didSet {
            view?.showFavorites()
        }
    }
    
    required init(view: FavoriteViewProtocol, favoritesService: FavoritesService) {
        self.view = view
        self.favoritesService = favoritesService
    }
    
    func loadFavorites() {
        items = favoritesService.loadFavorites()
    }
    
    func saveFavorites() {
        favoritesService.saveToFavorites(items: items)
    }

    func removeFromFavorites(index: Int) {
        items.remove(at: index)
        saveFavorites()
    }
    
}
