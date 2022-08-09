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
    init(view: MainViewProtocol, networkService: PicturesService)
    func loadPosts()
    func changeIsFavoriteFlagForItem(at index: Int)
    var items: [DetailItemModel] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: PicturesService!
    var items: [DetailItemModel] = []
    
    required init(view: MainViewProtocol, networkService: PicturesService) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadPosts() {
        networkService.loadPictures { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.items = pictures.map { pictureModel in
                    DetailItemModel(
                        imageUrlInString: pictureModel.photoUrl,
                        title: pictureModel.title,
                        isFavorite: false, // TODO: - Need adding `FavoriteService`
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
    
    func changeIsFavoriteFlagForItem(at index: Int) {
        let range = 0..<items.count
        if range.contains(index) {
            items[index].isFavorite.toggle()
        }
    }
    
}
