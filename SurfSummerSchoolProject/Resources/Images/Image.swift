//
//  Image.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

enum Image {
    
    enum NavigationBar {
        static let backIcon = UIImage(named: "backIcon")
        static let searchIcon = UIImage(named: "searchIcon")
    }
    
    enum TabBar {
        static let mainTab = UIImage(named: "mainTab")
        static let favoriteTab = UIImage(named: "favoriteTab")
        static let profileTab = UIImage(named: "profileTab")
    }
    
    enum Button {
        static let clearButtonIcon = UIImage(named: "clearButtonIcon")
        static let heartFill = UIImage(named: "heart-fill")
        static let heart = UIImage(named: "heart")
    }
    
    enum ImageView {
        static let searchFailedIcon = UIImage(named: "searchFailedIcon")
        static let searchScreenIcon = UIImage(named: "searchScreenIcon")
    }
    
    enum LaunchScreen {
        static let surfSplash = UIImage(named: "surfSplash")
    }
    
}
