//
//  SearchViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol SearchViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: BaseViewProtocol, items: [DetailItemModel], delegate: BasePresenterDelegate?, mainScreenDelegate: BasePresenterDelegate?)
    func searchItems(by title: String)
}
