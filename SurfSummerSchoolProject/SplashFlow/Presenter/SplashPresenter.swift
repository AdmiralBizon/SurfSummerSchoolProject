//
//  SplashPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 25.08.2022.
//

import UIKit

protocol SplashPresenterProtocol: AnyObject {
    func getSplashScreen() -> UIViewController
    func startAnimatingSplashScreen()
    func stopAnimatingSplashScreen()
}

final class SplashPresenter {
    
    // MARK: - Private properties
    
    private let view = SplashViewController()
    
}

// MARK: - SplashPresenterProtocol

extension SplashPresenter: SplashPresenterProtocol {
    func getSplashScreen() -> UIViewController {
        view
    }
    
    func startAnimatingSplashScreen() {
        view.startAnimation()
    }
    
    func stopAnimatingSplashScreen() {
        view.stopAnimation()
    }
}
