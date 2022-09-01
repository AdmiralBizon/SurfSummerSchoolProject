//
//  SplashViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 25.08.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Views
    
    @IBOutlet private weak var logoImageView: UIImageView!
    
    // MARK: - Private properties
    
    private var animator = UIViewPropertyAnimator()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public methods
    
    func startAnimation() {
        createAnimation()
    }
    
    func stopAnimation() {
        animator.stopAnimation(true)
    }
    
}

// MARK: - Private methods

private extension SplashViewController {
    func createAnimation() {
        // Pulse animation
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            
        }, completion: { [weak self] _ in
            self?.logoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self?.repeatAnimation()
        })
    }
    
    func repeatAnimation() {
        self.createAnimation()
    }
}
