//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Владислав Климов on 04.08.2022.
//

import UIKit

final class MainItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Public properties
    
    override var isHighlighted: Bool {
        didSet {
            animateCellAtTouch()
        }
    }
    
    var delegate: FavoritesButtonDelegate?
    
    // MARK: - Private properties
    
    private var isFavorite: Bool = false {
        didSet {
            setFavoriteButtonImage()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func favotiteAction(_ sender: UIButton) {
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
    
    // MARK: - Public methods
    
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
        titleLabel.textColor = Color.black
        titleLabel.font = .systemFont(ofSize: 12)
        
        imageView.layer.cornerRadius = 12
        
        favoriteButton.tintColor = Color.white
    }
    
    func setFavoriteButtonImage() {
        let buttonImage = isFavorite ? Image.Button.heartFill : Image.Button.heart
        favoriteButton.setImage(buttonImage, for: .normal)
    }
    
}
