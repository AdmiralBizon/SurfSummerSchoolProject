//
//  NewLoginTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import UIKit

final class NewLoginTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet private weak var loginTextField: FloatingTextField!

    // MARK: - Public methods
    
    func configure(delegate: FloatingTextFieldDelegate?, tag: Int, validationStatus: ValidationStatus) {
        loginTextField.tag = tag
        loginTextField.txtDelegate = delegate
        
        if let greyColor = Color.greySeparator, let redColor = Color.redSeparator {
            let settedColor = validationStatus != .success ? redColor : greyColor
            loginTextField.setBottomLineColor(settedColor)
        }
    }
    
}
