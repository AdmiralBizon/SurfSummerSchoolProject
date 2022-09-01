//
//  SearchPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

final class SearchPresenter: SearchViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: BaseViewProtocol?
    private var items: [DetailItemModel]
    private var dataStore: DataStore?
    private weak var delegate: BasePresenterDelegate?
    private weak var mainScreenDelegate: BasePresenterDelegate?
    
    // MARK: - Initializers
    
    init(view: BaseViewProtocol,
         items: [DetailItemModel],
         dataStore: DataStore?,
         delegate: BasePresenterDelegate?,
         mainScreenDelegate: BasePresenterDelegate?) {
        
        self.view = view
        self.items = items
        self.dataStore = dataStore
        self.delegate = delegate
        self.mainScreenDelegate = mainScreenDelegate
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
            
            delegate?.reloadItem(itemId: itemId)
            mainScreenDelegate?.reloadItem(itemId: itemId)
        }
        
    }
    
    func showDetails(for item: DetailItemModel) {
        view?.showDetails(for: item)
    }
    
    func getDataStore() -> DataStore? {
        dataStore
    }
    
}
