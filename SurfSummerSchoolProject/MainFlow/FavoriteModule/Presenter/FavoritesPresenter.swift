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
    private let dataStore: DataStore?
    private weak var delegate: BasePresenterDelegate?
    
    // MARK: - Initializers
    
    init(view: FavoritesViewProtocol,
         dataStore: DataStore?,
         delegate: BasePresenterDelegate?) {
        self.view = view
        self.dataStore = dataStore
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func loadFavorites() {
        let items = dataStore?.getFavorites() ?? []
        
        if !items.isEmpty {
            view?.showPosts(items)
        } else {
            view?.showEmptyState()
        }
    }
    
    func getItems() -> [DetailItemModel] {
        dataStore?.getFavorites() ?? []
    }
    
    func changeFavorites(itemId: Int) {
        if let _ = dataStore?.getItemFromFavorites(itemId: String(itemId)) {
            dataStore?.changeFavorites(itemId: String(itemId))
            delegate?.reloadItem(itemId: String(itemId)) // reload item at main screen
            loadFavorites()
        }
    }
    
    func prepareToRemoveItem(itemId: Int) {
        view?.showAlertBeforeRemovingItem(itemId: itemId)
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
}
