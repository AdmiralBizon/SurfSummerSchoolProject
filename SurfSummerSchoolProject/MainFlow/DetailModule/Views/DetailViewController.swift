//
//  DetailViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    private enum Constants {
        static let imageCellId = "\(DetailImageTableViewCell.self)"
        static let titleCellId = "\(DetailTitleTableViewCell.self)"
        static let textCellId = "\(DetailTextTableViewCell.self)"
    }
    
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
//        let searchViewController = ModuleBuilder.createSearchModule(items: [])
//        navigationController?.pushViewController(searchViewController, animated: true)
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

        tableView.register(UINib(nibName: Constants.imageCellId, bundle: .main),
                           forCellReuseIdentifier: Constants.imageCellId)
        tableView.register(UINib(nibName: Constants.titleCellId, bundle: .main),
                           forCellReuseIdentifier: Constants.titleCellId)
        tableView.register(UINib(nibName: Constants.textCellId, bundle: .main),
                           forCellReuseIdentifier: Constants.textCellId)
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
        
        guard let item = presenter.item else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.imageCellId) as? DetailImageTableViewCell {
                cell.configure(item: item)
                return cell
            }
            return UITableViewCell()
            
        case 1:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.titleCellId) as? DetailTitleTableViewCell {
                cell.configure(item: item)
                return cell
            }
            return UITableViewCell()
            
        case 2:
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.textCellId) as? DetailTextTableViewCell {
                cell.configure(item: item)
                return cell
            }
            return UITableViewCell()
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
