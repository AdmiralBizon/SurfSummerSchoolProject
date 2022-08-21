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
    
    // MARK: - Initializers
    
    init(view: ProfileViewProtocol, user: User?) {
        self.view = view
        self.user = user
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
        
    }
    
    func runAuthFlow() {
        //
    }
    
}
