//
//  UITableView.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import UIKit

extension UITableView {
    func registerCell(_ cellType: UITableViewCell.Type) {
        let nib = UINib(nibName: "\(cellType.self)", bundle: .main)
        self.register(nib, forCellReuseIdentifier: "\(cellType.self)")
    }
}
