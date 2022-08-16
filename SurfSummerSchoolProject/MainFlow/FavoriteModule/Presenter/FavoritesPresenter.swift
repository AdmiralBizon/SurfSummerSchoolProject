//
//  FavoritesPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol FavoritesViewProtocol: BaseViewProtocol {
    func showAlertBeforeRemovingItem(itemId: Int)
}

protocol FavoritesViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: FavoritesViewProtocol, favoritesService: FavoritesService)
    func loadFavorites()
    func showAlertBeforeRemove(itemId: Int)
    func getItemsCollectionForSearch() -> [DetailItemModel]
}

final class FavoritesPresenter: FavoritesViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: FavoritesViewProtocol?
    private let favoritesService: FavoritesService?
    
    // MARK: - Initializers
    
    init(view: FavoritesViewProtocol, favoritesService: FavoritesService) {
        self.view = view
        self.favoritesService = favoritesService
    }
    
    // MARK: - Public methods
    
    func loadFavorites() {
        let items = favoritesService?.loadFavorites() ?? []
        
        if !items.isEmpty {
            view?.showPosts(items)
        } else {
            view?.showEmptyState()
        }
    }
    
    func getItemsCollectionForSearch() -> [DetailItemModel] {
        favoritesService?.loadFavorites() ?? []
    }
    
    func changeFavorites(itemId: Int) {
        if let item = favoritesService?.getItemFromFavorites(itemId: String(itemId)) {
            favoritesService?.removeFromFavorites(item: item)
            loadFavorites()
        }
    }
    
    func showAlertBeforeRemove(itemId: Int) {
        view?.showAlertBeforeRemovingItem(itemId: itemId)
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
}
