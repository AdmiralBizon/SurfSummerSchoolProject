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
    
    // MARK: - Public Properties
    
    public var didTapBlock: (() -> ())?
    
    // MARK: - Private properties
    
    private var height: CGFloat = 95.0
    private var duration = 0.3
    private var delay: Double = 5.0
    
    private var titleFrame: CGRect!
    private var topLabel = UILabel()
    private var messageLabel = UILabel()
    
    private var statusBarHeight: CGFloat = 0.0
    private let screenWidth = UIScreen.main.bounds.size.width
    
    private let titleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
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
    
    func showAlert(_ title: String,
                   message: String? = nil,
                   topLabelColor: UIColor = Color.white,
                   messageLabelColor: UIColor = Color.white,
                   backgroundColor: UIColor = Color.lightRed ?? .red) {
        
        show(title: title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor)
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
        topLabel.font = self.titleFont
        addSubview(topLabel)
    }
    
    func show(title: String, message: String?, topLabelColor: UIColor, messageLabelColor: UIColor, backgroundColor: UIColor?) {
        
        addWindowSubview(self)
        configureProperties(title, message: message, topLabelColor: topLabelColor, messageLabelColor: messageLabelColor, backgroundColor: backgroundColor)
        
        UIView.animate(withDuration: self.duration, animations: {
            self.frame.origin.y = 0
        })
        perform(#selector(hide), with: self, afterDelay: self.delay)
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
    
    func configureProperties(_ title: String, message: String?, topLabelColor: UIColor?, messageLabelColor: UIColor?, backgroundColor: UIColor?) {
        
        topLabel.text = title
        
        if let message = message {
            messageLabel.text = message
        } else {
            messageLabel.isHidden = true
            topLabel.frame.origin.y = height/2
        }
        
        if let topLabelColor = topLabelColor {
            topLabel.textColor = topLabelColor
        }
        
        if let messageLabelColor = messageLabelColor {
            messageLabel.textColor = messageLabelColor
        }
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
    
    @objc func viewDidTap() {
        if let didTapBlock = didTapBlock {
            didTapBlock()
            hide(self)
        }
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

