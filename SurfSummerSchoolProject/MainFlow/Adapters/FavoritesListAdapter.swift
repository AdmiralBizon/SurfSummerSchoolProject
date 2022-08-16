//
//  FavoritesListAdapter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation
import UIKit

final class FavoritesListAdapter: NSObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let frameWidth: CGFloat = UIScreen.main.bounds.width
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenRows: CGFloat = 16
        static let multiplier: CGFloat = 1.17
        static let itemCellId = "\(FavoritesItemCollectionViewCell.self)"
    }
    
    // MARK: - Events

    var didSelectItem: SelectItemClosure?
    var didChangeFavorites: ChangeFavoritesClosure?
    
   // MARK: - Private properties
    
    private let collectionView: UICollectionView
    private var items: [DetailItemModel] = []

    // MARK: - Initializers
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    // MARK: - Public methods
    
    func configure(items: [DetailItemModel]) {
        self.items = items
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension FavoritesListAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.itemCellId,
                                                      for: indexPath)
        if let cell = cell as? FavoritesItemCollectionViewCell {
            let item = items[indexPath.item]
            cell.configure(item)
            cell.delegate = self
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesListAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = Constants.frameWidth - Constants.horisontalInset * 2
        return CGSize(width: itemWidth, height: Constants.multiplier * itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelectItem?(item)
    }
    
}

// MARK: - FavoritesButtonDelegate

extension FavoritesListAdapter: FavoritesButtonDelegate {
    
    func favoritesButtonPressed(at itemId: Int) {
        didChangeFavorites?(itemId)
    }
    
}
