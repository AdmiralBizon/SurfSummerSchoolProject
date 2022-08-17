//
//  FavoritesViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol FavoritesViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: FavoritesViewProtocol, favoritesService: FavoritesService)
    func loadFavorites()
    func prepareToRemoveItem(itemId: Int)
    func getItems() -> [DetailItemModel]
    func reloadMainScreen()
}
