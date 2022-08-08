//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Constants

    enum SearchErrors: Error {
        case noResults
    }
    
    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }
    
    // MARK: - Views
    
    @IBOutlet weak var searchStatusImageView: UIImageView!
    @IBOutlet weak var searchStatusLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    lazy private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    private var searchResults = [DetailItemModel]()
    
    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
        configureApperance()
    }

}

// MARK: - Private methods

private extension SearchViewController {
    
    func configureNavigationBar() {
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"),
                                                           style: .plain,
                                                           target: navigationController,
                                                           action: #selector(UINavigationController.popViewController(animated:)))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureSearchBar() {
        if let clearButton = searchBar.searchTextField.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clearButtonIcon"), for: .normal)
        }
        searchBar.becomeFirstResponder()
    }
    
    func configureApperance() {
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    func searchPosts(by title: String, completionHandler: (Result<[DetailItemModel],SearchErrors>) -> Void) {
       
        let allPosts = Array(repeating: DetailItemModel.createDefault(), count: 100)
        let filteredPosts = allPosts.filter { $0.title.lowercased().contains(title.lowercased()) }
        
        switch !filteredPosts.isEmpty {
        case true: completionHandler(.success(filteredPosts))
        case false: completionHandler(.failure(.noResults))
        }
    
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if let searchText = searchBar.text {
            searchResults = []
            
            searchPosts(by: searchText) { [weak self] response in
                switch response {
                case .success(let posts):
                    searchResults = posts
                    DispatchQueue.main.async {
                        self?.collectionView.isHidden = false
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        self?.collectionView.isHidden = true
                        self?.searchStatusImageView.image = UIImage(named: "searchFailedIcon")
                        self?.searchStatusLabel.text = """
                        По этому запросу нет результатов,
                        попробуйте другой запрос.
                        """
                    }
                }
                
            }
        }
        
    }
    
}

// MARK: - UICollectionView

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = searchResults[indexPath.row]
            cell.title = item.title
            cell.isFavorite = item.isFavorite
            //cell.image = item.image
            cell.imageUrlInString = item.imageUrlInString
            cell.didFavoritesTapped = { [weak self] in
                self?.searchResults[indexPath.row].isFavorite.toggle()
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.horisontalInset * 2 - Constants.spaceBetweenElements) / 2
        return CGSize(width: itemWidth, height: 1.46 * itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenRows
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spaceBetweenElements
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.model = searchResults[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}
