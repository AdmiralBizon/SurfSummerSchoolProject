//
//  FavoritesViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: FavoritesViewPresenterProtocol!
    
    // MARK: - Views
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var emptyListImageView: UIImageView!
    @IBOutlet private weak var emptyListLabel: UILabel!
    
    // MARK: - Private properties
    
    private var adapter: FavoritesListAdapter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdapter()
        configureApperance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        presenter.loadFavorites()
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
            self?.presenter.prepareToRemoveItem(itemId: itemId)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Избранное"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.NavigationBar.searchIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
        let items = presenter.getItems()
        let searchViewController = ModuleBuilder.createSearchModule(items: items, delegate: self)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func configureApperance() {
        emptyListImageView.isHidden = true
        emptyListLabel.isHidden = true
        
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.registerCell(FavoritesItemCollectionViewCell.self)
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
    }
    
}

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
    
    func reloadMainScreen() {
        if let navigationController = tabBarController?.viewControllers?[0] as? UINavigationController,
           let mainViewController = navigationController.viewControllers[0] as? MainViewController {
            mainViewController.reloadCollection()
        }
    }
    
}

// MARK: - BaseViewDelegate

extension FavoritesViewController: BaseViewDelegate {
    func reloadCollection() {
        presenter.loadFavorites()
        presenter.reloadMainScreen()
    }
}
