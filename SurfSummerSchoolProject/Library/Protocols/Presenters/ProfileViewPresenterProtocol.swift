//
//  ProfileViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import Foundation

protocol ProfileViewPresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, user: User?, authService: AuthService)
    func getUser() -> User?
    func prepareToLogout()
    func logout()
    func runAuthFlow()
}
