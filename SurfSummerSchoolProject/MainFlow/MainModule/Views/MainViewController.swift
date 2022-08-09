//
//  MainViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let horisontalInset: CGFloat = 16
        static let spaceBetweenElements: CGFloat = 7
        static let spaceBetweenRows: CGFloat = 8
    }

    // MARK: - Public properties
    
    var presenter: MainViewPresenterProtocol!
    
    // MARK: - Private Properties

    private var activityIndicator = UIActivityIndicatorView()

    // MARK: - Views

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var placeholderView: UIView!

    // MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    func configureNavigationBar() {
        navigationItem.title = "Главная"
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
        placeholderView.isHidden = true
        
        collectionView.register(UINib(nibName: "\(MainItemCollectionViewCell.self)", bundle: .main),
                                forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }

    func configureActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.items.count 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? MainItemCollectionViewCell {
            let item = presenter.items[indexPath.item]
            cell.configure(item)
            cell.didFavoritesTapped = { [weak self] in
                self?.presenter.changeIsFavoriteFlagForItem(at: indexPath.item)
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
        let item = presenter.items[indexPath.item]
        let detailViewController = ModuleBuilder.createDetailModule(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func showPosts() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.placeholderView.isHidden = true
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
            self.placeholderView.isHidden = false
            
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showErrorState(error: Error) {
        print(error)
    }
    
}
