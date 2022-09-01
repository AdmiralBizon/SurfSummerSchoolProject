//
//  Builder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

protocol Builder {
    static func prepareForStartMainFlow()
    static func prepateForEndMainFlow()
    static func createAuthModule() -> UIViewController
    static func createMainModule() -> UIViewController
    static func createDetailModule(item: DetailItemModel?) -> UIViewController
    static func createSearchModule(items: [DetailItemModel], delegate: BasePresenterDelegate?, useMainModuleDelegate: Bool) -> UIViewController
    static func createFavoriteModule() -> UIViewController
    static func createProfileModule() -> UIViewController
}
