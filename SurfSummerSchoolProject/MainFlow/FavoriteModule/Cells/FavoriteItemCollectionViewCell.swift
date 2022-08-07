//
//  FavoriteItemCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 07.08.2022.
//

import UIKit

class FavoriteItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let fillHeartImage = UIImage(named: "heart-fill")
        static let heartImage = UIImage(named: "heart")
    }

    // MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var detailTextLabel: UILabel!
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

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    var content: String = "" {
        didSet {
            detailTextLabel.text = content
        }
    }
    
    var isFavorite: Bool = true {
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

}

// MARK: - Private Methods

private extension FavoriteItemCollectionViewCell {

    func configureAppearance() {
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = UIColor(named: "CustomGrey")
        
        detailTextLabel.font = .systemFont(ofSize: 12, weight: .light)
        detailTextLabel.textColor = .black
        detailTextLabel.numberOfLines = 1
        
        favoriteButton.tintColor = .white
        isFavorite = true
    }

}