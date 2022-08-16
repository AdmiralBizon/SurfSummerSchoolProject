//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Владислав Климов on 04.08.2022.
//

import UIKit

protocol FavoritesButtonDelegate: AnyObject {
    func favoritesButtonPressed(at itemId: Int)
}

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

    //var didFavoritesTapped: (() -> Void)?

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

    var delegate: FavoritesButtonDelegate?
    //var delegate: BasePresenter?
    
    // MARK: - Actions

    @IBAction private func favotiteAction(_ sender: UIButton) {
        //didFavoritesTapped?()
        delegate?.favoritesButtonPressed(at: sender.tag)
        isFavorite.toggle()
    }

    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        imageView.image = nil
        isFavorite = false
    }
    
    func configure(_ item: DetailItemModel) {
        titleLabel.text = item.title
       
        if let url = URL(string: item.imageUrlInString) {
            imageView.loadImage(from: url)
        }
        
        if let tag = Int(item.id) {
            favoriteButton.tag = tag
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
