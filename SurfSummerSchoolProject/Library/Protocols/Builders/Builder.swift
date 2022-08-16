//
//  Builder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(item: DetailItemModel?) -> UIViewController
    static func createSearchModule(items: [DetailItemModel], delegate: BaseViewDelegate?) -> UIViewController
    static func createFavoriteModule() -> UIViewController
}
