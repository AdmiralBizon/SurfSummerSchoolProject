//
//  DetailPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

final class DetailPresenter: DetailViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: DetailViewProtocol?
    private var item: DetailItemModel?
    
    // MARK: - Initializers
    
    init(view: DetailViewProtocol, item: DetailItemModel?) {
        self.view = view
        self.item = item
    }
    
    // MARK: - Public methods
    
    func getItem() -> DetailItemModel? {
        item
    }
    
    func reloadData() {
        view?.updateScreen()
    }
    
}
