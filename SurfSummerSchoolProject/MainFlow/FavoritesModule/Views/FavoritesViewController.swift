//
//  FavoritesViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenRows: CGFloat = 16
        static let multiplier: CGFloat = 1.17
        static let itemCellId = "\(FavoritesItemCollectionViewCell.self)"
    }
    
    // MARK: - Public properties
    
    var presenter: FavoritesViewPresenterProtocol!
    
    // MARK: - Private properties
    private var adapter: FavoritesListAdapter?
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyListImageView: UIImageView!
    @IBOutlet weak var emptyListLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdapter()
        configureApperance()
        presenter.loadFavorites()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        
    }
    
}

// MARK: - Private methods

private extension FavoritesViewController {

    func configureAdapter() {
        adapter = FavoritesListAdapter(collectionView: collectionView)
        adapter?.didSelectItem = { [weak self] item in
            self?.presenter.showDetails(for: item)
        }
        adapter?.didChangeFavorites = { [weak self] itemId in
            self?.presenter.showAlertBeforeRemove(itemId: itemId)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
//        let items = presenter.items
//        let searchViewController = ModuleBuilder.createSearchModule(items: items)
//        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func configureApperance() {
        emptyListImageView.isHidden = true
        emptyListLabel.isHidden = true
        
        collectionView.register(UINib(nibName: Constants.itemCellId, bundle: .main),
                                forCellWithReuseIdentifier: Constants.itemCellId)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
    }

//    @objc func showAlert(_ sender: UIButton) {
//
//        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите удалить из избранного?", preferredStyle: .alert)
//
//        let removeAction = UIAlertAction(title: "Да, точно", style: .default, handler: { [weak self] _ in
//            self?.removeItemFromFavorites(index: sender.tag)
//          })
//        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
//
//        alert.addAction(removeAction)
//        alert.addAction(cancelAction)
//
//        alert.preferredAction = removeAction
//
//        present(alert, animated: true)
//
//    }
    
//    func removeItemFromFavorites(index: Int) {
//        //presenter.removeFromFavorites(index: index)
//        presenter.changeFavorites(itemId: index)
//    }
    
}

//// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
//
//extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        presenter.items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.itemCellId,
//                                                      for: indexPath)
//        if let cell = cell as? FavoriteItemCollectionViewCell {
//            let item = presenter.items[indexPath.item]
//
//            cell.configure(item)
//            cell.favoriteButton.tag = indexPath.row
//            cell.favoriteButton.addTarget(self, action: #selector(showAlert(_:)), for: .touchUpInside)
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemWidth = view.frame.width - Constants.horisontalInset * 2
//        return CGSize(width: itemWidth, height: Constants.multiplier * itemWidth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return Constants.spaceBetweenRows
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = presenter.items[indexPath.item]
//        let detailViewController = ModuleBuilder.createDetailModule(item: item)
//        navigationController?.pushViewController(detailViewController, animated: true)
//    }
//
//}

// MARK: - FavoritesViewProtocol

extension FavoritesViewController: FavoritesViewProtocol {
    
    func showPosts(_ posts: [DetailItemModel]) {
        DispatchQueue.main.async {
            self.emptyListLabel.isHidden = true
            self.emptyListImageView.isHidden = true
            self.collectionView.isHidden = false
            
            self.adapter?.configure(items: posts)
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.emptyListLabel.isHidden = false
            self.emptyListImageView.isHidden = false
        }
    }
    
    func showDetails(for item: DetailItemModel) {
        let detailViewController = ModuleBuilder.createDetailModule(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func showAlertBeforeRemovingItem(itemId: Int) {
        let alert = UIAlertController(title: "Внимание",
                                      message: "Вы точно хотите удалить из избранного?",
                                      preferredStyle: .alert)
        
        let removeAction = UIAlertAction(title: "Да, точно", style: .default, handler: { [weak self] _ in
            self?.presenter.changeFavorites(itemId: itemId)
        })
        
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        
        alert.preferredAction = removeAction
        
        present(alert, animated: true)
    }
    
}
