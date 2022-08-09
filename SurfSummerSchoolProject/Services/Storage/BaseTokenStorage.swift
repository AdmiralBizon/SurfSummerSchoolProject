//
//  BaseTokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

struct BaseTokenStorage: TokenStorage {

     func getToken() throws -> TokenContainer {
         TokenContainer(
            token: "595d9f58b8ac34689b1326e2cf4ef803882995c267a00ce34c6220f4a6d8ed6a"
         )
     }

     func set(newToken: TokenContainer) throws { }

 }
