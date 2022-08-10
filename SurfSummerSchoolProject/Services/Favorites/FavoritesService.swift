//
//  FavoritesService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

struct FavoritesService {
    
    private let userDefaults = UserDefaults.standard
    
    func loadFavorites() -> [DetailItemModel] {
        
        var favorites = [DetailItemModel]()
        
        if let savedObject = userDefaults.object(forKey: "favorites") as? Data {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([DetailItemModel].self, from: savedObject) {
                favorites = decodedData
            }
        }
        
        return favorites
    }
    
    func saveToFavorites(items: [DetailItemModel]) {
        let encoder = JSONEncoder()
        if let encodedObject = try? encoder.encode(items) {
            userDefaults.set(encodedObject, forKey: "favorites")
        }
    }
    
    func addToFavorites(item: DetailItemModel) {
        var currentFavorites = loadFavorites()
        if !currentFavorites.contains(item) {
            currentFavorites.append(item)
            saveToFavorites(items: currentFavorites)
        }
        
    }
    
    func removeFromFavorites(item: DetailItemModel) {
        var currentFavorites = loadFavorites()
        if let index = currentFavorites.firstIndex(of: item) {
            currentFavorites.remove(at: index)
            saveToFavorites(items: currentFavorites)
        }
    }
    
    func isFavorite(itemId: String) -> Bool {
        guard !itemId.isEmpty else { return false }
        let currentFavorites = loadFavorites()
        return (currentFavorites.filter{ $0.id == itemId }.first) != nil
    }
    
}
