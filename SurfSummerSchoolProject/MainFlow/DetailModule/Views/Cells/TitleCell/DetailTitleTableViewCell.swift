//
//  DetailTitleTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

final class DetailTitleTableViewCell: UITableViewCell {

    // MARK: - Views

    @IBOutlet private weak var cartTitleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    // MARK: - Public methods
    
    func configure(item: DetailItemModel?) {
        guard let item = item else {
            return
        }
        cartTitleLabel.text = item.title
        dateLabel.text = item.dateCreation
    }
    
}

// MARK: - Private methods

private extension DetailTitleTableViewCell {
    func configureAppearance() {
        selectionStyle = .none
        cartTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = Color.lightGrey
    }
}
