//
//  AuthService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

struct AuthService {

     let dataTask = BaseNetworkTask<AuthRequestModel, AuthResponseModel>(
         isNeedInjectToken: false,
         method: .post,
         path: "auth/login"
     )

    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, Error>) -> Void
    ) {
        dataTask.performRequest(input: credentials) { result in
            if case let .success(responseModel) = result {
                do {
                    try dataTask.tokenStorage.set(newToken: TokenContainer(token: responseModel.token, receivingDate: Date()))
                } catch {
                    // TODO: - Handle error if token not was received from server
                }
            }
            
            onResponseWasReceived(result)
        }
     }

 }
