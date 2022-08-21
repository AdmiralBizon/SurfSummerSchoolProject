//
//  ProfileViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 03.08.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Enums
    
    private enum CellTypes: Int, CaseIterable {
        case header
        case city
        case phone
        case email
    }
    
    // MARK: - Views
    
    private let tableView = UITableView()
    private let logoutButton = LoadingButton()
    
    // MARK: - Public properties

    var presenter: ProfileViewPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
}

// MARK: - Private methods

private extension ProfileViewController {
    func configureAppearance() {
        configureLogoutButton()
        configureTableView()
    }

    func configureLogoutButton() {
        view.addSubview(logoutButton)

        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            logoutButton.widthAnchor.constraint(equalTo: logoutButton.heightAnchor, multiplier: 343 / 48)
        ])

        logoutButton.setTitle("Выйти", for: .normal)
        logoutButton.setTitleColor(Color.white, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed(_:)), for: .touchUpInside)
    }

    func configureTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -16)
        ])

        tableView.contentInset = .init(top: 10, left: 0, bottom: 10, right: 0)
        tableView.registerCell(HeaderTableViewCell.self)
        tableView.registerCell(UserDetailTableViewCell.self)

        tableView.dataSource = self
        tableView.layoutMargins = .zero
        tableView.separatorInset = .zero
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Профиль"
    }
    
    @objc func logoutButtonPressed(_ sender: LoadingButton) {
        presenter.prepareToLogout()
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellTypes.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let user = presenter.getUser(),
              let cellType = CellTypes(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        if cellType == .header {
            return configureHeaderCell(tableView, indexPath: indexPath, user: user)
        } else {
            return configureDetailCell(tableView, indexPath: indexPath, cellType: cellType, user: user)
        }
    }
}

// MARK: - Configure cells

extension ProfileViewController {
    private func configureHeaderCell(_ tableView: UITableView, indexPath: IndexPath, user: User?) -> UITableViewCell {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.headerCellId, for: indexPath) as? HeaderTableViewCell else {
            return UITableViewCell()
        }
        headerCell.configure(user: user)
        // hide separator at header cell
        headerCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        return headerCell
    }
    
    private func configureDetailCell(_ tableView: UITableView, indexPath: IndexPath, cellType: CellTypes, user: User?) -> UITableViewCell {
        guard let detailCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.usedDetailCellId, for: indexPath) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .city:
            detailCell.configure(title: "Город", subtitle: user?.city)
        case .phone:
            let maskedPhone = Validator.applyPhoneMask(phoneNumber: user?.phone ?? "")
            detailCell.configure(title: "Телефон", subtitle: maskedPhone)
        case .email:
            detailCell.configure(title: "Почта", subtitle: user?.email)
        default:
            return UITableViewCell()
        }
        
        return detailCell
    }
}

// MARK: - ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showAlertBeforeLogout(message: String, cancelActionTitle: String, defaultActionTitle: String) {
        showAlert(message: message,
                  cancelActionTitle: cancelActionTitle,
                  defaultActionTitle: defaultActionTitle) {
            DispatchQueue.main.async {
                self.view.isUserInteractionEnabled = false
                self.logoutButton.startLoading()
            }
            self.presenter.logout()
        }
    }
    
    func stopLoadingAnimation() {
        self.logoutButton.stopLoading()
    }
    
    func showErrorState(message: String) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = true
            self.showErrorState(message)
        }
    }
}
