//
//  UserInfoModel.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 18.08.2022.
//

import Foundation

struct UserInfoModel: Codable {
    let id: String
    let phone: String
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    let city: String
    let about: String
 }
