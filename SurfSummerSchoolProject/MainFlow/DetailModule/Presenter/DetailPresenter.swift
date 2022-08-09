//
//  DetailPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func showDetails(item: DetailItemModel?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, item: DetailItemModel?)
    func showDetails()
    var item: DetailItemModel? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var item: DetailItemModel?
    
    required init(view: DetailViewProtocol, item: DetailItemModel?) {
        self.view = view
        self.item = item
    }
    
    public func showDetails() {
        view?.showDetails(item: item)
    }
    
}
