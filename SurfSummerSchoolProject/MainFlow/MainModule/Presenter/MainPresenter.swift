//
//  MainPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func showPosts(_ posts: [DetailItemModel])
    func showEmptyState()
    func showDetails(for item: DetailItemModel)
}

protocol BaseViewPresenterProtocol: AnyObject {
    func changeFavorites(itemId: Int)
    func showDetails(for item: DetailItemModel)
}

protocol BaseViewDelegate: AnyObject {
    func reloadCollection()
}

protocol MainViewProtocol: BaseViewProtocol {
    func showErrorState(error: Error)
}

protocol MainViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: MainViewProtocol, dataStore: DataStore)
    func loadPosts()
    func getItemsCollectionForSearch() -> [DetailItemModel]
}

final class MainPresenter: MainViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: MainViewProtocol?
    private let dataStore: DataStore?
    
    // MARK: - Initializers
    
    init(view: MainViewProtocol, dataStore: DataStore) {
        self.view = view
        self.dataStore = dataStore
    }
    
    // MARK: - Public methods
    
    func loadPosts() {
        dataStore?.loadPosts(completion: { [weak self] result in
            switch result {
            case .success(let posts):
                if !posts.isEmpty  {
                    self?.view?.showPosts(posts)
                } else {
                    self?.view?.showEmptyState()
                }
            case .failure(let error):
                self?.view?.showErrorState(error: error)
            }
        })
    }
    
    func getItemsCollectionForSearch() -> [DetailItemModel] {
        dataStore?.getItemsCollectionForSearch(onlyFavorites: false) ?? []
    }
    
    func changeFavorites(itemId: Int) {
        dataStore?.changeFavorites(itemId: String(itemId))
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
}
