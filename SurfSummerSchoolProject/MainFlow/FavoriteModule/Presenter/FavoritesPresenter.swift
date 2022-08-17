//
//  FavoritesPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

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
        let items = favoritesService?.getFavorites() ?? []
        
        if !items.isEmpty {
            view?.showPosts(items)
        } else {
            view?.showEmptyState()
        }
    }
    
    func getItems() -> [DetailItemModel] {
        favoritesService?.getFavorites() ?? []
    }
    
    func changeFavorites(itemId: Int) {
        if let item = favoritesService?.getItemFromFavorites(itemId: String(itemId)) {
            favoritesService?.removeFromFavorites(item: item)
            view?.reloadMainScreen() // reload collection at main screen
            loadFavorites()
        }
    }
    
    func prepareToRemoveItem(itemId: Int) {
        view?.showAlertBeforeRemovingItem(itemId: itemId)
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
    func reloadMainScreen() {
        view?.reloadMainScreen()
    }
    
}
