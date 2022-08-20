//
//  Coordinator.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import Foundation
import UIKit

struct Coordinator {
    
    static func runMainFlow() {
        let duration: TimeInterval = 0.3
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
                return
            }
            
            let tabBarViewController = TabBarConfigurator().configure()
            
            UIView.transition(with: window, duration: duration, options: options, animations: {
                window.rootViewController = tabBarViewController
            })
        }
        
    }
    
}
