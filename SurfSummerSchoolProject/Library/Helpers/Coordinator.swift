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
        static let duration: TimeInterval = 0.5
        static let options: UIView.AnimationOptions = .transitionFlipFromRight
    }
    
    // MARK: - Public methods
    
    static func runMainFlow(_ timeout: DispatchTime = .now() + 0) {
        
        ModuleBuilder.prepareForStartMainFlow()
        
        DispatchQueue.main.asyncAfter(deadline: timeout) {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
                return
            }
            
            let tabBarViewController = TabBarConfigurator().configure()
            
            UIView.transition(with: window, duration: Constants.duration, options: Constants.options, animations: {
                window.rootViewController = tabBarViewController
            })
        }
        
    }
    
    static func runAuthFlow(_ timeout: DispatchTime = .now() + 0, isNeedShowErrorState: Bool = false) {
        
        DispatchQueue.main.asyncAfter(deadline: timeout) {
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
