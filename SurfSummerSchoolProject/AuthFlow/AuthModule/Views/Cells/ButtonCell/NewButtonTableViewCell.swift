//
//  NewButtonTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import UIKit

class NewButtonTableViewCell: UITableViewCell {

    // MARK: - Views
    
    private let loginButton = LoadingButton()
    
    // MARK: - Private properties
    
    private var delegate: LoadingButtonDelegate?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    // MARK: - Public methods
    
    func configure(delegate: LoadingButtonDelegate?) {
        self.delegate = delegate
    }
    
}

// MARK: - Private methods

private extension NewButtonTableViewCell {
    func configureAppearance(){
        
        addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: leftAnchor),
            loginButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor),
            loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed(_ button: LoadingButton) {
        delegate?.buttonPressed(button)
    }
}
