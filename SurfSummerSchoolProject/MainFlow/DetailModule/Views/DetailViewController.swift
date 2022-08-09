//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: - Views

    private let tableView = UITableView()

    // MARK: - Public properties

    var presenter: DetailViewPresenterProtocol!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        presenter.showDetails()
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

    func configureNavigationBar() {
        navigationItem.title = presenter.item?.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"),
                                                           style: .plain,
                                                           target: navigationController,
                                                           action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "searchIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    @objc func searchButtonPressed(_ sender: UIBarButtonItem) {
        let searchController = SearchViewController()
        searchController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(searchController, animated: true)
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

        tableView.register(UINib(nibName: "\(DetailImageTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTitleTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DetailTextTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DetailTextTableViewCell.self)")
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailImageTableViewCell.self)")
            if let cell = cell as? DetailImageTableViewCell {
                cell.imageUrlInString = presenter.item?.imageUrlInString ?? ""
            }
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTitleTableViewCell.self)")
            if let cell = cell as? DetailTitleTableViewCell {
                cell.title = presenter.item?.title ?? ""
                cell.date = presenter.item?.dateCreation ?? ""
            }
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTextTableViewCell.self)")
            if let cell = cell as? DetailTextTableViewCell {
                cell.text = presenter?.item?.content
            }
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }

}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func showDetails(item: DetailItemModel?) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
