//
//  UICollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

extension UICollectionViewCell {
    func animateCellAtTouch() {
        UIView.animate(withDuration: 0.2) {
            self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
        }
    }
}
