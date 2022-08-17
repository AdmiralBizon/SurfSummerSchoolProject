//
//  FavoritesItemCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 07.08.2022.
//

import UIKit

final class FavoritesItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var detailTextLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Public properties
    
    override var isHighlighted: Bool {
        didSet {
            animateCellAtTouch()
        }
    }
    
    var delegate: FavoritesButtonDelegate?
    
    // MARK: - Actions
    
    @IBAction private func favotiteAction(_ sender: UIButton) {
        delegate?.favoritesButtonPressed(at: sender.tag)
    }
    
    // MARK: - UICollectionViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        detailTextLabel.text = nil
        imageView.image = nil
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
        
        detailTextLabel.text = item.content
        dateLabel.text = item.dateCreation
    }
    
}

// MARK: - Private Methods

private extension FavoritesItemCollectionViewCell {
    
    func configureAppearance() {
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        dateLabel.textColor = Color.lightGrey
        
        detailTextLabel.font = .systemFont(ofSize: 12, weight: .regular)
        detailTextLabel.textColor = Color.black
        detailTextLabel.numberOfLines = 1
        
        favoriteButton.tintColor = Color.white
        favoriteButton.setImage(Image.Button.heartFill, for: .normal)
    }
    
}
