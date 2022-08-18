//
//  FavoritesViewProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol FavoritesViewProtocol: BaseViewProtocol {
    func showAlertBeforeRemovingItem(itemId: Int)
}
