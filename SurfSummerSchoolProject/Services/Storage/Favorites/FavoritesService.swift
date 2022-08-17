//
//  FavoritesService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

final class FavoritesService {
    
    // MARK: - Public properties
    
    static let shared = FavoritesService()
    
    // MARK: - Private properties
    
    private var favorites = [DetailItemModel]() {
        didSet {
            saveFavorites()
        }
    }
    
    // MARK: - Initializers
    
    private init() {
        loadFavorites()
    }
    
    // MARK: - Public methods
    
    func getFavorites() -> [DetailItemModel] {
        favorites
    }
    
    func addToFavorites(item: DetailItemModel) {
        if !favorites.contains(item) {
            favorites.append(item)
        }
        
    }
    
    func removeFromFavorites(item: DetailItemModel) {
        if let index = favorites.firstIndex(of: item) {
            favorites.remove(at: index)
        }
    }
    
    func getItemFromFavorites(itemId: String) -> DetailItemModel? {
        guard !itemId.isEmpty else { return nil }
        let item = favorites.first { $0.id == itemId }
        return item
    }
    
    func isFavorite(itemId: String) -> Bool {
        guard !itemId.isEmpty else { return false }
        return (favorites.filter{ $0.id == itemId }.first) != nil
    }
    
}

// MARK: - Private methods

private extension FavoritesService {
    func loadFavorites() {
        favorites = []
        let loadedData: [DetailItemModel]? = LocalStorage().value(for: LocalStorageKeys.favorites)
        if let loadedData = loadedData {
            favorites = loadedData
        }
    }
    
    func saveFavorites() {
        LocalStorage().set(value: favorites, for: LocalStorageKeys.favorites)
    }
}
