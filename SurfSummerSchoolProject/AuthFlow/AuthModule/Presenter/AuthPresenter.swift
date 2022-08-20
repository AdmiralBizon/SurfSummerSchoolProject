//
//  AuthPresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import Foundation

final class AuthPresenter: AuthViewPresenterProtocol {
    
    // MARK: - Private properties
    
    private weak var view: AuthViewProtocol?
    private let authService: AuthService?
    
    // MARK: - Initializers
    
    init(view: AuthViewProtocol, authService: AuthService) {
        self.view = view
        self.authService = authService
    }
    
    // MARK: - Public methods
    
    func maskPhoneNumber(phone: String) -> String {
        Validator.applyMask(to: phone)
    }
    
    func validateAuthData(login: String, password: String) {
        let loginValidationResult = Validator.validateLogin(login: login)
        if loginValidationResult != .success {
            view?.showValidationStatus(status: loginValidationResult)
            return
        }
        
        let passwordValidationResult = Validator.validatePassword(password: password)
        if passwordValidationResult != .success {
            view?.showValidationStatus(status: passwordValidationResult)
            return
        }
        
        view?.showValidationStatus(status: .success)
    }
    
    func makeAuthRequest(login: String, password: String) {
        let unmaskedLogin = Validator.unmask(phoneNumber: login)
        
        let credentials = AuthRequestModel(phone: unmaskedLogin, password: password)
        authService?.performLoginRequestAndSaveToken(credentials: credentials) { [weak self] result in
            self?.view?.stopLoadingAnimation()
            switch result {
            case .success:
                self?.runMainFlow()
            case .failure:
                self?.view?.showErrorState(message: "Логин или пароль введен неправильно")
            }
        }
        
    }
    
    func runMainFlow() {
        Coordinator.runMainFlow()
    }
}
