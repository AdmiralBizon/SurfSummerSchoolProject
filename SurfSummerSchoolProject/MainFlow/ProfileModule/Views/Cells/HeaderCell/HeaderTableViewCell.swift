//
//  HeaderTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import UIKit

final class HeaderTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userAboutLabel: UILabel!
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        userNameLabel.text = nil
        userAboutLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(user: User?) {
        guard let user = user else {
            return
        }

        if let about = user.about {
            userAboutLabel.text = "«\(about)»"
        }
        
        if let firstName = user.firstName, let lastName = user.lastName {
            userNameLabel.text = "\(firstName) \n\(lastName)"
        }
    
        if let avatar = user.avatar, let url = URL(string: avatar) {
            userImageView?.loadImage(from: url)
        }
    }
    
}

// MARK: - Private methods

private extension HeaderTableViewCell {
    func configureAppearance() {
        selectionStyle = .none
        userImageView.layer.cornerRadius = 12
        userImageView.contentMode = .scaleAspectFill
    }
}
