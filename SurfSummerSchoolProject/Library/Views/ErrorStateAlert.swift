//
//  ErrorStateAlert.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 17.08.2022.
//
// Based on JDropDownAlert library
// from https://github.com/trilliwon/JDropDownAlert

import Foundation
import UIKit

final class ErrorStateAlert: UIButton {
    
    // MARK: - Private properties
    
    private let height: CGFloat = 95.0
    private let duration = 0.3
    private let delay: Double = 5.0
    
    private var titleFrame: CGRect!
    private var topLabel = UILabel()
    private let titleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    private var statusBarHeight: CGFloat = 0.0
    private let screenWidth = UIScreen.main.bounds.size.width
    
    // MARK: - Initializers
    
    init(statusBarHeight: CGFloat) {
        super.init(frame: CGRect.zero)
        self.statusBarHeight = statusBarHeight
        setDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public methods
    
    func showAlert(_ title: String) {
        show(title: title)
    }
    
}

// MARK: - Private methods

private extension ErrorStateAlert {
    
    func setDefaults() {
        self.frame = CGRect(x: 0.0, y: -height, width: screenWidth, height: height)
        self.backgroundColor = Color.lightRed
        self.addTarget(self, action: #selector(viewDidTap), for: .touchUpInside)
        setTitleDefaults()
    }
    
    func setTitleDefaults() {
        titleFrame = CGRect(x: 10,
                            y: statusBarHeight,
                            width: frame.size.width - 10,
                            height: 40)
        
        topLabel = UILabel(frame: titleFrame)
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        topLabel.textColor = UIColor.white
        topLabel.font = titleFont
        addSubview(topLabel)
    }
    
    func show(title: String) {
        
        addWindowSubview(self)
        configureProperties(title)
        
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y = 0
        })
        perform(#selector(hide), with: self, afterDelay: delay)
    }
    
    func addWindowSubview(_ view: UIView) {
        if self.superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal
                    && !window.isHidden
                    && window.frame != CGRect.zero {
                    window.addSubview(view)
                    return
                }
            }
        }
    }
    
    func configureProperties(_ title: String) {
        topLabel.text = title
        topLabel.frame.origin.y = height / 2
    }
    
    @objc func viewDidTap() {
        hide(self)
    }
    
    @objc func hide(_ alertView: UIButton) {
        
        UIView.animate(withDuration: duration, animations: {
            alertView.frame.origin.y = -self.height
        })
        
        perform(#selector(remove), with: alertView, afterDelay: delay)
        
    }
    
    @objc func remove(_ alertView: UIButton) {
        alertView.removeFromSuperview()
    }
    
}

