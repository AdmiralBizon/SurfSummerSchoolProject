//
//  TokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

protocol TokenStorage {
     func getToken() throws -> TokenContainer
     func set(newToken: TokenContainer) throws
 }
