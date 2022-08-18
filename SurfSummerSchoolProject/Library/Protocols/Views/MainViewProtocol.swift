//
//  MainViewProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol MainViewProtocol: BaseViewProtocol {
    func showErrorState(error: Error)
    func reloadItemAt(indexPath: IndexPath, in collection: [DetailItemModel])
}
