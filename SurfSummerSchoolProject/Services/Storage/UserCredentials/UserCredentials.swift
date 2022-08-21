//
//  UserCredentials.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 20.08.2022.
//

import Foundation

struct UserCredentials: Codable {
    let login: String
    let password: String
    let token: TokenContainer
    
    init(login: String, password: String, token: TokenContainer) {
        self.login = login
        self.password = password
        self.token = token
    }
    
}
