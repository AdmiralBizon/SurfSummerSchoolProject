//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum CellTypes: Int, CaseIterable {
        case detailImage
        case detailTitle
        case detailText
    }
    
    // MARK: - Views

    private let tableView = UITableView()
    
    // MARK: - Public properties

    var presenter: DetailViewPresenterProtocol!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        presenter.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

}

// MARK: - Private Methods

private extension DetailViewController {

    func configureAppearance() {
        configureTableView()
    }

    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchViewController = ModuleBuilder.createSearchModule(items: [],
                                                                    delegate: nil)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.registerCell(DetailImageTableViewCell.self)
        tableView.registerCell(DetailTitleTableViewCell.self)
        tableView.registerCell(DetailTextTableViewCell.self)
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

}

// MARK: - UIGestureRecognizerDelegate

extension DetailViewController: UIGestureRecognizerDelegate {
    
    private func configureNavigationBar() {
        navigationItem.title = presenter.getItem()?.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Image.NavigationBar.backIcon,
                                                           style: .plain,
                                                           target: navigationController,
                                                           action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Image.NavigationBar.searchIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellType = CellTypes(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .detailImage:
            return configureImageCell(tableView, indexPath: indexPath)
        case .detailTitle:
            return configureTitleCell(tableView, indexPath: indexPath)
        case .detailText:
            return configureTextCell(tableView, indexPath: indexPath)
        }
        
    }

}

// MARK: - Configure cells

private extension DetailViewController {
    func configureImageCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let imageCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.detailImageCellId, for: indexPath) as? DetailImageTableViewCell else {
            return UITableViewCell()
        }
        imageCell.configure(item: presenter.getItem())
        return imageCell
    }
    
    func configureTitleCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let titleCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.detailTitleCellId, for: indexPath) as? DetailTitleTableViewCell else {
            return UITableViewCell()
        }
        titleCell.configure(item: presenter.getItem())
        return titleCell
    }
    
    func configureTextCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let textCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.detailTextCellId, for: indexPath) as? DetailTextTableViewCell else {
            return UITableViewCell()
        }
        textCell.configure(item: presenter.getItem())
        return textCell
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func updateScreen() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
