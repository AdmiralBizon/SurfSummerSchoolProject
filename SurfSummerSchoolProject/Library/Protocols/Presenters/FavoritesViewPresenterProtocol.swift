//
//  FavoritesViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol FavoritesViewPresenterProtocol: BaseViewPresenterProtocol, BasePresenterDelegate {
    init(view: FavoritesViewProtocol, dataStore: DataStore?, delegate: BasePresenterDelegate?)
    func loadFavorites()
    func prepareToRemoveItem(itemId: Int)
    func getItems() -> [DetailItemModel]
}
