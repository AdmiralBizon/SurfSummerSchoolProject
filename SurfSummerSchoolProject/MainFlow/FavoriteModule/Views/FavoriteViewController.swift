//
//  FavoriteViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenRows: CGFloat = 16
    }
    
    // MARK: - Public properties
    
    var presenter: FavoriteViewPresenterProtocol!
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        presenter.loadFavorites()
    }
    
}

// MARK: - Private methods

private extension FavoriteViewController {

    func configureNavigationBar() {
        navigationItem.title = "Избранное"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
        let items = presenter.items
        let searchViewController = ModuleBuilder.createSearchModule(items: items)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }

    @objc func showAlert(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Да, точно", style: .default, handler: { [weak self] _ in
            self?.removeItemFromFavorites(index: sender.tag)
          }))

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))

        present(alert, animated: true)
    }
    
    func removeItemFromFavorites(index: Int) {
        presenter.removeFromFavorites(index: index)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteItemCollectionViewCell {
            let item = presenter.items[indexPath.item]

            cell.configure(item)
            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = view.frame.width - Constants.horisontalInset * 2
        return CGSize(width: itemWidth, height: 1.17 * itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.items[indexPath.item]
        let detailViewController = ModuleBuilder.createDetailModule(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - FavoriteViewProtocol

extension FavoriteViewController: FavoriteViewProtocol {
    func showFavorites() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
