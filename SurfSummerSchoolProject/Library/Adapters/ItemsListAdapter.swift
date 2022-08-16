//
//  CollectionViewDataSource.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 15.08.2022.
//

import Foundation
import UIKit

typealias SelectItemClosure = (DetailItemModel) -> Void
typealias ChangeFavoritesClosure = (Int) -> Void
typealias CollectionScrollClosure = () -> Void

final class ItemsListAdapter: NSObject {
    
    // MARK: - Constants
    
    private enum Constants {
        static let frameWidth: CGFloat = UIScreen.main.bounds.width
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
        static let multiplier: CGFloat = 1.46 // width/height at Figma design
    }
    
    // MARK: - Events

    var didSelectItem: SelectItemClosure?
    var didChangeFavorites: ChangeFavoritesClosure?
    var didCollectionScroll: CollectionScrollClosure?
    
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

extension ItemsListAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionView.itemCellId,
                                                      for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = items[indexPath.item]
            cell.configure(item)
            cell.delegate = self
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ItemsListAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (Constants.frameWidth - Constants.horisontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: Constants.multiplier * itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelectItem?(item)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        didCollectionScroll?()
    }
    
}

// MARK: - FavoritesButtonDelegate

extension ItemsListAdapter: FavoritesButtonDelegate {
    func favoritesButtonPressed(at itemId: Int) {
        didChangeFavorites?(itemId)
    }
}
