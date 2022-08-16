//
//  DetailImageTableViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {

    // MARK: - Views

    @IBOutlet private weak var cartImageView: UIImageView!
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cartImageView.layer.cornerRadius = 12
        cartImageView.contentMode = .scaleAspectFill
    }
    
    func configure(item: DetailItemModel) {
        guard let url = URL(string: item.imageUrlInString) else {
            return
        }
        cartImageView?.loadImage(from: url)
    }
    
}
