//
//  UIViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 17.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func getStatusBarHeight() -> CGFloat {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    func showErrorState(_ message: String) {
        let alert = ErrorStateAlert(statusBarHeight: getStatusBarHeight())
        alert.showAlert(message)
    }
    
    func showAlert(message: String, cancelActionTitle: String, defaultActionTitle: String, _ actionsToPerformAtDefault: @escaping () -> Void
    ) {
        
        let alert = UIAlertController(title: "Внимание",
                                      message: message,
                                      preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: defaultActionTitle,
                                          style: .default,
                                          handler: { _ in
            actionsToPerformAtDefault()
        })
        
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        alert.preferredAction = defaultAction
        
        present(alert, animated: true)
        
    }
    
}
