//
//  AuthViewPresenterProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import Foundation

protocol AuthViewPresenterProtocol: AnyObject {
    init(view: AuthViewProtocol, authService: AuthService)
    func maskPhoneNumber(phone: String) -> String
    func validateAuthData(login: String, password: String)
    func makeAuthRequest(login: String, password: String)
    func runMainFlow()
}
