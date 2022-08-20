//
//  AuthViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let numberOfRowsInSection = 1
        static let buttonCellHeaderHeight: CGFloat = 32
        static let defaultCellHeaderHeight: CGFloat = 16
        static let defaultCellFooterHeight: CGFloat = 0
        static let cellWithErrorStateFooterHeight: CGFloat = 23
        static let rowHeight: CGFloat = 56
        static let passwordMaximumLength = 255
        
        static let errorStateMessages = [
            ValidationStatus.emptyLogin: "Поле не может быть пустым",
            ValidationStatus.emptyPassword: "Поле не может быть пустым",
            ValidationStatus.loginDoesNotMatchMask: "Неверный формат номера телефона",
            ValidationStatus.passwordDoesNotMatchLength: "Пароль должен быть от 6 до 255 символов"
        ]
        
        enum CellTypes: Int, CaseIterable {
            case login
            case password
            case button
        }
    }
    
    // MARK: - Public properties
    
    var presenter: AuthViewPresenterProtocol!
    
    // MARK: - Views
    
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    // MARK: - Private properties
    
    private var login = ""
    private var password = ""
    private var loginValidationStatus = ValidationStatus.success
    private var passwordValidationStatus = ValidationStatus.success
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
}

// MARK: - Private methods

private extension AuthViewController {
    func configureAppearance(){
        configureTitleLabel()
        configureTableView()
    }
    
    func configureTitleLabel() {
        titleLabel.text = "Вход"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = Color.black
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.registerCell(NewLoginTableViewCell.self)
        tableView.registerCell(NewPasswordTableViewCell.self)
        tableView.registerCell(ButtonTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .onDrag
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableView.addGestureRecognizer(dismissKeyboardGesture)
        
    }
    
    func createErrorStateView(with message: String?) -> UIView {
        let errorStateView = UIView()
        
        let errorLabel = UILabel()
        errorLabel.text = message
        errorLabel.font = .systemFont(ofSize: 12, weight: .regular)
        errorLabel.textColor = Color.redSeparator
        
        errorStateView.addSubview(errorLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(equalTo: errorStateView.leftAnchor, constant: 18),
            errorLabel.topAnchor.constraint(equalTo: errorStateView.topAnchor, constant: 7),
            errorLabel.rightAnchor.constraint(equalTo: errorStateView.rightAnchor)
        ])
        
        return errorStateView
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getDataFrom(_ textField: UITextField) {
        guard let cellType = Constants.CellTypes(rawValue: textField.tag) else {
            return
        }
        
        if cellType == .login {
            login = textField.text ?? ""
        } else {
            password = textField.text ?? ""
        }
    }
    
    func activateTextField(tag: Int) {
        if let destinationCell = tableView.cellForRow(at: IndexPath(item: 0, section: tag)),
           let destinationTextField = destinationCell.viewWithTag(tag) as? FloatingTextField {
            destinationTextField.becomeFirstResponder()
        }
    }
    
    func stopAnimatingLoginButton() {
        let tag = Constants.CellTypes.button.rawValue
        if let buttonCell = tableView.cellForRow(at: IndexPath(item: 0, section: tag)),
           let loginButton = buttonCell.viewWithTag(tag) as? LoadingButton {
            loginButton.stopLoading()
        }
    }
    
}

// MARK: - UITableViewDatasource, UITableViewDelegate

extension AuthViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.CellTypes.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let cellType = Constants.CellTypes(rawValue: section) else {
            return 0
        }
        
        switch cellType {
        case .login, .password:
            return Constants.defaultCellHeaderHeight
        case .button:
            return Constants.buttonCellHeaderHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cellType = Constants.CellTypes(rawValue: section) else {
            return nil
        }
        
        switch cellType {
        case .login:
            let errorMessage = Constants.errorStateMessages[loginValidationStatus]
            return createErrorStateView(with: errorMessage)
        case .password:
            let errorMessage = Constants.errorStateMessages[passwordValidationStatus]
            return createErrorStateView(with: errorMessage)
        case .button:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let cellType = Constants.CellTypes(rawValue: section) else {
            return 0
        }
        
        switch cellType {
        case .login:
            return loginValidationStatus != .success ? Constants.cellWithErrorStateFooterHeight : Constants.defaultCellFooterHeight
        case .password:
            return passwordValidationStatus != .success ? Constants.cellWithErrorStateFooterHeight : Constants.defaultCellFooterHeight
        case .button:
            return Constants.defaultCellFooterHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = Constants.CellTypes(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch cellType {
        case .login:
            return configureLoginCell(tableView, indexPath: indexPath)
        case .password:
            return configurePasswordCell(tableView, indexPath: indexPath)
        case .button:
            return configureButtonCell(tableView, indexPath: indexPath)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }
    
}

// MARK: - Configure cells

extension AuthViewController {
    func configureLoginCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let loginCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.loginCellId, for: indexPath) as? NewLoginTableViewCell else {
            return UITableViewCell()
        }
        loginCell.configure(delegate: self, tag: indexPath.section, validationStatus: loginValidationStatus)
        return loginCell
    }
    
    func configurePasswordCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let passwordCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.passwordCellId, for: indexPath) as? NewPasswordTableViewCell else {
            return UITableViewCell()
        }
        passwordCell.configure(delegate: self, tag: indexPath.section, validationStatus: passwordValidationStatus)
        return passwordCell
    }
    
    func configureButtonCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: K.TableView.buttonCellId, for: indexPath) as? ButtonTableViewCell else {
            return UITableViewCell()
        }
        buttonCell.configure(delegate: self, tag: indexPath.section)
        return buttonCell
    }
}

// MARK: - FloatingTextFieldDelegate

extension AuthViewController: FloatingTextFieldDelegate {
    func floatingTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let cellType = Constants.CellTypes(rawValue: textField.tag),
              let text = textField.text else {
                  return false
              }
        
        if cellType == .login {
            let phoneNumber = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = presenter.maskPhoneNumber(phone: phoneNumber)
            return false
        } else if cellType == .password {
            // limit password max length
            guard let stringRange = Range(range, in: text) else {
                return false
            }
            
            let updatedPassword = text.replacingCharacters(in: stringRange, with: string)
            return updatedPassword.count <= Constants.passwordMaximumLength
        }
        
        return true
    }
    
    func floatingTextFieldRightViewClick(_ textField: UITextField) {
        guard let cellType = Constants.CellTypes(rawValue: textField.tag),
              cellType == .password else {
                  return
              }
        
        if let rightView = textField.rightView as? UIButton {
            if textField.isSecureTextEntry {
                rightView.setImage(Image.Button.openedEye, for: .normal)
            } else {
                rightView.setImage(Image.Button.closedEye, for: .normal)
            }
            textField.isSecureTextEntry.toggle()
        }
    }
    
    func floatingTextFieldDidEndEditing(_ textField: UITextField) {
        getDataFrom(textField)
        
        if Constants.CellTypes(rawValue: textField.tag) == .login {
            activateTextField(tag: textField.tag + 1) // activate password textField
        }
    }
    
    func floatingTextFieldShouldReturn(_ textField: UITextField) {
        getDataFrom(textField)
    }
}

// MARK: - LoadingButtonDelegate

extension AuthViewController: LoadingButtonDelegate {
    func buttonPressed(_ button: LoadingButton) {
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            button.startLoading()
        }
        
        loginValidationStatus = .success
        passwordValidationStatus = .success
        
        presenter.validateAuthData(login: login, password: password)
    }
}

// MARK: - AuthViewProtocol

extension AuthViewController: AuthViewProtocol {
    func showValidationStatus(status: ValidationStatus) {
        switch status {
        case .emptyLogin, .loginDoesNotMatchMask:
            loginValidationStatus = status
        case .emptyPassword, .passwordDoesNotMatchLength:
            passwordValidationStatus = status
        case .success:
            presenter.makeAuthRequest(login: login, password: password)
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.isUserInteractionEnabled = true
            self.stopAnimatingLoginButton()
            self.tableView.reloadData()
        }
    }
    
    func showErrorState(message: String) {
        DispatchQueue.main.async {
            self.showErrorState(message)
        }
    }
    
    func stopLoadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopAnimatingLoginButton()
        }
    }
    
}
