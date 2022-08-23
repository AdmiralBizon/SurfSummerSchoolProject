//
//  ProfilePresenter.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import Foundation

final class ProfilePresenter: ProfileViewPresenterProtocol {
   
    // MARK: - Private properties
    
    private weak var view: ProfileViewProtocol?
    private let user: User?
    private let authService: AuthService
    
    // MARK: - Initializers
    
    init(view: ProfileViewProtocol, user: User?, authService: AuthService) {
        self.view = view
        self.user = user
        self.authService = authService
    }
    
    // MARK: - Public methods
    
    func getUser() -> User? {
        user
    }
    
    func prepareToLogout() {
        view?.showAlertBeforeLogout(message: "Вы точно хотите выйти из приложения?",
                        cancelActionTitle: "Нет",
                        defaultActionTitle: "Да, точно")
    }
    
    func logout() {
        authService.performLogoutRequestAndRemoveCredentials { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.view?.stopLoadingAnimation()
                switch result {
                case .success:
                    self?.runAuthFlow()
                case .failure:
                    self?.view?.showErrorState(message: "Не удалось выйти, попробуйте еще раз")
                }
            }
        }
    }
    
    func runAuthFlow() {
        ModuleBuilder.prepateForEndMainFlow()
        Coordinator.runAuthFlow()
    }
    
}
