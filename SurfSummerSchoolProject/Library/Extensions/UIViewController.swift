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
    
}
