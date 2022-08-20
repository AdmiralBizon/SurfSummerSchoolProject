//
//  NewPasswordTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import UIKit

class NewPasswordTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet private weak var passwordTextField: FloatingTextField!

    // MARK: - Public methods
    
    func configure(delegate: FloatingTextFieldDelegate?, tag: Int, validationStatus: ValidationStatus) {
        passwordTextField.tag = tag
        passwordTextField.txtDelegate = delegate
        
        if let greyColor = Color.greySeparator, let redColor = Color.redSeparator {
            let settedColor = validationStatus != .success ? redColor : greyColor
            passwordTextField.setBottomLineColor(settedColor)
        }
    }

}
