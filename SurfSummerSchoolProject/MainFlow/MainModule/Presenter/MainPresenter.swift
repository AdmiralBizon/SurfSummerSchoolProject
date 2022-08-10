//
//  MainPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func showPosts()
    func showEmptyState()
    func showErrorState(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: PicturesService, favoritesService: FavoritesService)
    func loadPosts()
    func changeFavoritesByItem(at index: Int)
    var items: [DetailItemModel] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: PicturesService!
    let favoritesService: FavoritesService!
    var items: [DetailItemModel] = []
    
    required init(view: MainViewProtocol, networkService: PicturesService, favoritesService: FavoritesService) {
        self.view = view
        self.networkService = networkService
        self.favoritesService = favoritesService
    }
    
    func loadPosts() {
        networkService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        id: pictureModel.id,
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        //isFavorite: false, // TODO: - Need adding `FavoriteService`
                        isFavorite: self?.favoritesService.isFavorite(itemId: pictureModel.id) ?? false,
                        content: pictureModel.content,
                        dateCreation: pictureModel.date
                    )
                }
                
                if self?.items.isEmpty == false  {
                    self?.view?.showPosts()
                } else {
                    self?.view?.showEmptyState()
                }
                
            case .failure(let error):
                self?.view?.showErrorState(error: error)
            }
        }
    }
    
    func changeFavoritesByItem(at index: Int) {
        let range = 0..<items.count
        if range.contains(index) {
            
            var item = items[index]
            item.isFavorite.toggle()
            
            if !item.isFavorite {
                favoritesService.removeFromFavorites(item: item)
            } else {
                favoritesService.addToFavorites(item: item)
            }
            
        }
    }
    
}
