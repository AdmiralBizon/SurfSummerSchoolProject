//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Владислав Климов on 04.08.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let fillHeartImage = UIImage(named: "heart-fill")
        static let heartImage = UIImage(named: "heart")
    }

    // MARK: - Views

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Events

    var didFavoritesTapped: (() -> Void)?

    // MARK: - Calculated

    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillHeartImage : Constants.heartImage
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
    
    // MARK: - Properties
    
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.setImage(buttonImage, for: .normal)
        }
    }

    // MARK: - Actions

    @IBAction private func favotiteAction(_ sender: UIButton) {
        didFavoritesTapped?()
        isFavorite.toggle()
    }

    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    func configure(_ item: DetailItemModel) {
        titleLabel.text = item.title
       
        if let url = URL(string: item.imageUrlInString) {
            imageView.loadImage(from: url)
        }
        
        isFavorite = item.isFavorite
    }
}

// MARK: - Private Methods

private extension MainItemCollectionViewCell {

    func configureAppearance() {
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 12)

        imageView.layer.cornerRadius = 12

        favoriteButton.tintColor = .white
    }

}