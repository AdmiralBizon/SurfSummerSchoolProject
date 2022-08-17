//
//  UICollectionView.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

extension UICollectionView {
    func registerCell(_ cellType: UICollectionViewCell.Type) {
        let nib = UINib(nibName: "\(cellType.self)", bundle: .main)
        self.register(nib, forCellWithReuseIdentifier: "\(cellType.self)")
    }
}
