//
//  SearchViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol SearchViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: BaseViewProtocol, dataStore: DataStore, items: [DetailItemModel], delegate: BaseViewDelegate?)
    func searchItems(by title: String)
}
