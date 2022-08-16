//
//  MainViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol MainViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: MainViewProtocol, dataStore: DataStore)
    func loadPosts()
    func getItemsCollectionForSearch() -> [DetailItemModel]
}
