//
//  SearchPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func showPosts()
    func showEmptyState()
}

protocol SearchViewPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, items: [DetailItemModel])
    func searchPosts(by title: String)
    func changeIsFavoriteFlagForItem(at index: Int)
    var items: [DetailItemModel] { get set }
    var filteredItems: [DetailItemModel] { get set }
}

class SearchPresenter: SearchViewPresenterProtocol {

    weak var view: SearchViewProtocol?
    var items: [DetailItemModel] = []
    var filteredItems: [DetailItemModel] = []
    
    required init(view: SearchViewProtocol, items: [DetailItemModel]) {
        self.view = view
        self.items = items
    }
    
    func searchPosts(by title: String) {
        filteredItems = []
        
        filteredItems = items.filter {
            $0.title.lowercased().contains(title.lowercased())
        }
        
        switch !filteredItems.isEmpty {
        case true: view?.showPosts()
        case false: view?.showEmptyState()
        }
        
    }
    
    func changeIsFavoriteFlagForItem(at index: Int) {
//        let range = 0..<filteredItems.count
//        if range.contains(index) {
//            let item = filteredItems[index].isFavorite.toggle()
//
//            let originalItem = items.first {}
//
//        }
    }
    
}
