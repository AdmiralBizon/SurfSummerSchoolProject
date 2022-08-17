//
//  DetailViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, item: DetailItemModel?)
    func getItem() -> DetailItemModel?
    func reloadData()
}
