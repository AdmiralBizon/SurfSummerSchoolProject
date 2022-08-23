//
//  Coordinator.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import Foundation
import UIKit

struct Coordinator {
    
    // MARK: - Constants
    
    private enum Constants {
        static let duration: TimeInterval = 0.3
        static let options: UIView.AnimationOptions = .transitionCrossDissolve
    }
    
    // MARK: - Public methods
    
    static func runMainFlow() {
        
        ModuleBuilder.prepareForStartMainFlow()
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
                return
            }
            
            let tabBarViewController = TabBarConfigurator().configure()
            
            UIView.transition(with: window, duration: Constants.duration, options: Constants.options, animations: {
                window.rootViewController = tabBarViewController
            })
        }
        
    }
    
    static func runAuthFlow(isNeedShowErrorState: Bool = false) {
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
                return
            }
            
            let authViewController = ModuleBuilder.createAuthModule()
            
            UIView.transition(with: window, duration: Constants.duration, options: Constants.options, animations: {
                window.rootViewController = authViewController
                
                if isNeedShowErrorState {
                    window.rootViewController?.showErrorState("Не удалось выполнить вход \nПовторите попытку позднее")
                }
                
            })
        }
    }
    
}
