//
//  MainPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

final class MainPresenter: MainViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: MainViewProtocol?
    private let dataStore: DataStore?
    
    // MARK: - Initializers
    
    init(view: MainViewProtocol, dataStore: DataStore?) {
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
    
    func getItems() -> [DetailItemModel] {
        dataStore?.getItems() ?? []
    }
    
    func changeFavorites(itemId: Int) {
        dataStore?.changeFavorites(itemId: String(itemId))
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
    func reloadItem(itemId: String) {
        if let itemIndex = dataStore?.getItemIndex(id: itemId) {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let items = dataStore?.getItems() ?? []
           
            view?.reloadItemAt(indexPath: indexPath, in: items)
        }
    }
    
}
