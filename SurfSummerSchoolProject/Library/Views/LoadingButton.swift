//
//  LoadingButton.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//
// Based on loading-buttons-ios library
// https://github.com/twho/loading-buttons-ios

import Foundation
import UIKit

final class LoadingButton: UIButton {
    
    // MARK: - Private properties
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Public properties
    
    var isLoading = false
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public methods
    
    func startLoading() {
        guard !subviews.contains(activityIndicator) else {
            return
        }
        
        isLoading = true
        isUserInteractionEnabled = false
        
        configureActivityIndicator()
        
        UIView.transition(with: self, duration: 0.2, options: .curveEaseOut) {
            self.titleLabel?.alpha = 0.0
        } completion: {_ in
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        guard subviews.contains(activityIndicator) else {
            return
        }
        
        isLoading = false
        isUserInteractionEnabled = true
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
       
        UIView.transition(with: self, duration: 0.2, options: .curveEaseIn) {
            self.titleLabel?.alpha = 1.0
        }
    }
    
}

// MARK: - Private methods

private extension LoadingButton {
    func setDefaultConfiguration() {
        backgroundColor = Color.black
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        tintColor = Color.white
    }
    
    func configureActivityIndicator() {
        activityIndicator.color = Color.white
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.center = center
        
        addSubview(activityIndicator)
    }
}
