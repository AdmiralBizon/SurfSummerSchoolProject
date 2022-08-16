//
//  SearchPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol SearchViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: BaseViewProtocol, dataStore: DataStore, items: [DetailItemModel], delegate: BaseViewDelegate?)
    func searchItems(by title: String)
}

final class SearchPresenter: SearchViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: BaseViewProtocol?
    private let dataStore: DataStore?
    private var items: [DetailItemModel]
    private weak var delegate: BaseViewDelegate?
    
    // MARK: - Initializers
    
    init(view: BaseViewProtocol, dataStore: DataStore, items: [DetailItemModel], delegate: BaseViewDelegate?) {
        self.view = view
        self.dataStore = dataStore
        self.items = items
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func searchItems(by title: String) {
        
        let filteredItems = items.filter {
            $0.title.lowercased().contains(title.lowercased())
        }
        
        if !filteredItems.isEmpty {
            view?.showPosts(filteredItems)
        } else {
            view?.showEmptyState()
        }
    }
    
    func changeFavorites(itemId: Int) {
        
        let itemId = String(itemId)
        
        if let index = items.firstIndex(where: { $0.id == itemId }) {
            dataStore?.changeFavorites(itemId: itemId)
            items[index].isFavorite.toggle()
            delegate?.reloadCollection() // reload collection at delegate screen
        }
        
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
}
