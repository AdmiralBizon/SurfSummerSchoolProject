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
    
    init(id: String,
         phone: String,
         email: String,
         firstName: String,
         lastName: String,
         avatar: String,
         city: String,
         about: String) {
        
        self.id = id
        self.phone = phone
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.city = city
        self.about = about
    }
    
 }
