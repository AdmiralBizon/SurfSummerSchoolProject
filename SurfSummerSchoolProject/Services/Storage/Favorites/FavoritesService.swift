//
//  FavoritesService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

final class FavoritesService {
    
    // MARK: - Private properties
    
    private var userPhone: String?
    
    // MARK: - Initializers
    
    init() {
        userPhone = getUserPhone()
    }
    
    // MARK: - Public methods
    
    func getFavorites() -> [DetailItemModel] {
        var favorites = [DetailItemModel]()
        
        let savedItems = CoreDataManager.shared.getFavorites(userPhone: userPhone)
        favorites = savedItems.map { item in
            DetailItemModel(
                id: item.id ?? "",
                imageUrlInString: item.imageURL ?? "",
                title: item.title ?? "",
                isFavorite: true,
                content: item.content ?? "",
                dateCreation: item.dateCreation ?? Date()
            )
        }
        return favorites
    }
    
    func addToFavorites(item: DetailItemModel) {
        CoreDataManager.shared.addToFavorites(userPhone: userPhone, item: item)
        
    }
    
    func removeFromFavorites(item: DetailItemModel) {
        CoreDataManager.shared.removeFromFavorites(userPhone: userPhone, itemId: item.id)
    }
    
    func getItemFromFavorites(itemId: String) -> DetailItemModel? {
        guard let savedItem = CoreDataManager.shared.getItemFromFavorites(userPhone: userPhone, itemId: itemId) else {
                  return nil
              }
        let item =  DetailItemModel(
            id: savedItem.id ?? "",
            imageUrlInString: savedItem.imageURL ?? "",
            title: savedItem.title ?? "",
            isFavorite: true,
            content: savedItem.content ?? "",
            dateCreation: savedItem.dateCreation ?? Date()
        )
        return item
    }
    
    func isFavorite(itemId: String) -> Bool {
        guard CoreDataManager.shared.getItemFromFavorites(userPhone: userPhone, itemId: itemId) != nil else {
            return false
        }
        return true
    }
    
}

// MARK: - Private methods

private extension FavoritesService {
    func getUserPhone() -> String? {
        guard let userPhone = try? UserCredentialsManager.shared.getCredentials().login else {
            return nil
        }
        return userPhone
    }
}
