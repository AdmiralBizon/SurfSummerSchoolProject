//
//  ButtonTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet weak var loginButton: LoadingButton!
   
    // MARK: - Private properties
    
    private var delegate: LoadingButtonDelegate?
    
    // MARK: - IBActions

    @IBAction private func loginButtonPressed(_ sender: LoadingButton) {
        delegate?.buttonPressed(sender)
    }
    
    // MARK: - Public methods
    
    func configure(delegate: LoadingButtonDelegate?, tag: Int) {
        loginButton.tag = tag
        self.delegate = delegate
    }
    
}
