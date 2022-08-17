//
//  TabBarModel.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorite
    case profile

    struct TabProperties {
        let title: String
        let image: UIImage?
        var selectedImage: UIImage? {
            image
        }
    }
    
    var properties: TabProperties {
        switch self {
        case .main:
            return TabProperties(title: "Главная", image: Image.TabBar.mainTab)
        case .favorite:
            return TabProperties(title: "Избранное", image: Image.TabBar.favoriteTab)
        case .profile:
            return TabProperties(title: "Профиль", image: Image.TabBar.profileTab)
        }
    }
    
}
