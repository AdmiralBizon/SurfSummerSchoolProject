//
//  UIImageView+ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import UIKit

extension UIImageView {
    
    func loadImage(from url: URL) {
        ImageLoader.shared.loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
    
}
