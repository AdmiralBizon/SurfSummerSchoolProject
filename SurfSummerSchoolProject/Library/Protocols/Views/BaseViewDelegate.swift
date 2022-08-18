//
//  BaseViewDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol BaseViewDelegate: AnyObject {
    func reloadCollection()
}

protocol BasePresenterDelegate: AnyObject {
    func reloadItem(itemId: String)
    func reloadCollection()
}

extension BasePresenterDelegate {
    func reloadItem(itemId: String) {}
    func reloadCollection() {}
}
