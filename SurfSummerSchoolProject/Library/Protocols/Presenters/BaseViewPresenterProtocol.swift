//
//  BaseViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol BaseViewPresenterProtocol: AnyObject {
    func changeFavorites(itemId: Int)
    func showDetails(for item: DetailItemModel)
}
