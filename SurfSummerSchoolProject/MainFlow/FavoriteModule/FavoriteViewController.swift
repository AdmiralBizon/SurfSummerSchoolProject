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
    
    // MARK: - Private Properties

    private let model: MainModel = .init()
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
        configureModel()
        //model.getPosts()
        model.loadPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
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
        let searchController = SearchViewController()
        searchController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchController, animated: true)
    }
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(FavoriteItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    @objc func changeFavorites(_ sender: UIButton) {
        removeFromFavorites(objectIndex: sender.tag)
    }
    
    func removeFromFavorites(objectIndex: Int) {
        
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Да, точно", style: .default, handler: { [weak self] _ in
            self?.model.items.remove(at: objectIndex)
          }))

        alert.addAction(UIAlertAction(title: "Нет", style: .cancel))

        present(alert, animated: true)
        
    }
    
}

// MARK: - UICollectionView

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(FavoriteItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? FavoriteItemCollectionViewCell {
            let item = model.items[indexPath.row]
            cell.title = item.title
            cell.isFavorite = true
            //cell.image = item.image
            cell.imageUrlInString = item.imageUrlInString
            cell.content = item.content
            cell.date = item.dateCreation

            cell.favoriteButton.tag = indexPath.row
            cell.favoriteButton.addTarget(self, action: #selector(changeFavorites(_:)), for: .touchUpInside)
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
        let vc = DetailViewController()
        //vc.model = model.items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
