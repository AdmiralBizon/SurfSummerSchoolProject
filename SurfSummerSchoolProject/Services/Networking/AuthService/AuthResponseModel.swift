//
//  AuthResponseModel.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

struct AuthResponseModel: Decodable {
    let token: String
    let userInfo: UserInfoModel
    
    enum CodingKeys: String, CodingKey {
        case token
        case userInfo = "user_info"
    }
}
