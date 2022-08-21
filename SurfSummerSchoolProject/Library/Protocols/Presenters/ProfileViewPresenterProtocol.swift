//
//  ProfileViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import Foundation

protocol ProfileViewPresenterProtocol: AnyObject {
    init(view: ProfileViewProtocol, user: User?)
    func getUser() -> User?
    func prepareToLogout()
    func logout()
    func runAuthFlow()
}
