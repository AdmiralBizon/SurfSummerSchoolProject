//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Constants
    
    private enum Constants {
        static let itemCellId = "\(MainItemCollectionViewCell.self)"
    }
    
    // MARK: - Public properties
    
    var presenter: SearchViewPresenterProtocol!
    
    // MARK: - Views
    
    @IBOutlet weak var searchStatusImageView: UIImageView!
    @IBOutlet weak var searchStatusLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private var searchBar = UISearchBar()
    private var adapter: PostsListAdapter?
    
    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAdapter()
        configureSearchBar()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        searchBar.becomeFirstResponder()
    }
    
}

// MARK: - Private methods

private extension SearchViewController {
    
    func configureAdapter() {
        adapter = PostsListAdapter(collectionView: collectionView)
        adapter?.didSelectItem = { [weak self] item in
            self?.presenter.showDetails(for: item)
        }
        adapter?.didChangeFavorites = { [weak self] itemId in
            self?.presenter.changeFavorites(itemId: itemId)
        }
        adapter?.didCollectionScroll = {
            self.searchBar.endEditing(true)
        }
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        if let clearButton = searchBar.searchTextField.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clearButtonIcon"), for: .normal)
        }
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: Constants.itemCellId, bundle: .main),
                                forCellWithReuseIdentifier: Constants.itemCellId)
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        collectionView.isHidden = true
    
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension SearchViewController: UIGestureRecognizerDelegate {

    private func configureNavigationBar() {
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"),
                                                           style: .plain,
                                                           target: navigationController,
                                                           action: #selector(UINavigationController.popViewController(animated:)))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
}
    
// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            presenter.searchItems(by: searchText)
        }
    }
    
}

// MARK: - BaseViewProtocol

extension SearchViewController: BaseViewProtocol {
    
    func showPosts(_ posts: [DetailItemModel]) {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.adapter?.configure(items: posts)
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.searchStatusImageView.image = UIImage(named: "searchFailedIcon")
            self.searchStatusLabel.text = """
                                        По этому запросу нет результатов,
                                        попробуйте другой запрос.
                                        """
        }
    }
    
    func showDetails(for item: DetailItemModel) {
        let detailViewController = ModuleBuilder.createDetailModule(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
