//
//  SearchViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchStatusImageView: UIImageView!
    @IBOutlet weak var searchStatusLabel: UILabel!
    
    lazy private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
    }

}

// MARK: - Private methods

private extension SearchViewController {
    
    func configureNavigationBar() {
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backButtonPressed(_:)))
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func configureSearchBar() {
        if let clearButton = searchBar.searchTextField.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clearButtonIcon"), for: .normal)
        }
        searchBar.becomeFirstResponder()
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchStatusImageView.image = UIImage(named: "searchFailedIcon")
            self.searchStatusLabel.text = """
            По этому запросу нет результатов,
            попробуйте другой запрос.
            """
        }
    }
    
}
