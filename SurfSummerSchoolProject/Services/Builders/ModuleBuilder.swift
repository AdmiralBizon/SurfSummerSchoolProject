//
//  ModuleBuilder.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 09.08.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(item: DetailItemModel?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let picturesService = PicturesService()
        let presenter = MainPresenter(view: view, networkService: picturesService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(item: DetailItemModel?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, item: item)
        view.presenter = presenter
        return view
    }
    
}
