//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Public properties
    
    var presenter: MainViewPresenterProtocol!
    
    // MARK: - Private Properties

    private var activityIndicator = UIActivityIndicatorView()
    private var adapter: ItemsListAdapter?

    // MARK: - Views

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var placeholderView: UIView!

    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdapter()
        configureApperance()
        configureActivityIndicator()
        activityIndicator.startAnimating()
        presenter.loadPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: - IBActions
    
    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.placeholderView.isHidden = true
            self.activityIndicator.startAnimating()
        }
        presenter.loadPosts()
    }
    
}

// MARK: - Private Methods

private extension MainViewController {

    func configureAdapter() {
        adapter = ItemsListAdapter(collectionView: collectionView)
        adapter?.didSelectItem = { [weak self] item in
            self?.presenter.showDetails(for: item)
        }
        adapter?.didChangeFavorites = { [weak self] itemId in
            self?.presenter.changeFavorites(itemId: itemId)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Главная"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.NavigationBar.searchIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
        let items = presenter.getItems()
        let searchViewController = ModuleBuilder.createSearchModule(items: items,
                                                                    delegate: presenter,
                                                                    useMainModuleDelegate: false)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func configureApperance() {
        placeholderView.isHidden = true
        
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        collectionView.registerCell(MainItemCollectionViewCell.self)
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self,
                                                 action: #selector(didPullToRefresh),
                                                 for: .valueChanged)
        
    }
    
    @objc func didPullToRefresh() {
        presenter.loadPosts()
    }

    func configureActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func showPosts(_ posts: [DetailItemModel]) {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.placeholderView.isHidden = true

            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }

            if self.collectionView.refreshControl?.isRefreshing == true {
                self.collectionView.refreshControl?.endRefreshing()
            }

            self.adapter?.reloadData(with: posts)
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.placeholderView.isHidden = false
            
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            
            if self.collectionView.refreshControl?.isRefreshing == true {
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    func showDetails(for item: DetailItemModel) {
        let detailViewController = ModuleBuilder.createDetailModule(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func showErrorState(error: Error) {
        DispatchQueue.main.async {
            if self.collectionView.refreshControl?.isRefreshing == true {
                self.collectionView.refreshControl?.endRefreshing()
            }
            self.showErrorState(error.localizedDescription)
        }
    }
    
    func reloadItemAt(indexPath: IndexPath, in collection: [DetailItemModel]) {
        DispatchQueue.main.async {
            self.adapter?.reloadData(at: indexPath, in: collection)
        }
    }
    
}

// MARK: - FavoritesButtonDelegate

extension MainViewController: FavoritesButtonDelegate {
    func favoritesButtonPressed(at itemId: Int) {
        presenter.changeFavorites(itemId: itemId)
    }
}
