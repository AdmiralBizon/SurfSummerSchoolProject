//
//  DataStore.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 14.08.2022.
//

import Foundation

final class DataStore {
    
    // MARK: - Public properties
    
    static let shared = DataStore()
    
    // MARK: - Private properties
    
    private let picturesService: PicturesService
    private let favoritesService: FavoritesService
    
    private var items: [DetailItemModel] = []
    
    // MARK: - Initializers
    
    private init() {
        self.picturesService = PicturesService()
        self.favoritesService = FavoritesService()
    }
    
    // MARK: - Public methods
    
    func changeFavorites(itemId: String) {
        guard !itemId.isEmpty else {
            return
        }
        
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            items[index].isFavorite.toggle()
            
            if !items[index].isFavorite {
                favoritesService.removeFromFavorites(item: items[index])
            } else {
                favoritesService.addToFavorites(item: items[index])
            }
        }
    }
    
    func loadPosts(completion: @escaping (_ result: Result<[DetailItemModel], Error>) -> Void) {
        picturesService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: self?.favoritesService.isFavorite(itemId: pictureModel.id) == true,
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
                completion(.success(self?.items ?? []))
                
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func getItemsCollectionForSearch(onlyFavorites: Bool) -> [DetailItemModel] {
        if onlyFavorites {
            return favoritesService.loadFavorites()
        } else {
            return items
        }
    }
    
}
