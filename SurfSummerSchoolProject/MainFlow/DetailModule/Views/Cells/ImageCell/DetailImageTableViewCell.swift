//
//  DetailImageTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

final class DetailImageTableViewCell: UITableViewCell {

    // MARK: - Views

    @IBOutlet private weak var cartImageView: UIImageView!
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    // MARK: - Public methods
    
    func configure(item: DetailItemModel?) {
        guard let item = item, let url = URL(string: item.imageUrlInString) else {
            return
        }
        cartImageView?.loadImage(from: url)
    }
    
}

// MARK: - Private methods

private extension DetailImageTableViewCell {
    func configureAppearance() {
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
}
