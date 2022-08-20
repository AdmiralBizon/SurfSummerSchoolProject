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
    
    func performLoginRequestAndSaveCredentials(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, Error>) -> Void
    ) {
        dataTask.performRequest(input: credentials) { result in
            switch result {
            case .success(let responseModel):
                do {
                    let userCredentials = UserCredentialsManager.shared.prepareCredentials(login: credentials.phone, password: credentials.password, token: responseModel.token)
                    
                    try UserCredentialsManager.shared.saveCredentials(userCredentials)
                    onResponseWasReceived(.success(responseModel))
                } catch (let error) {
                    print("Ошибка сохранения данных пользователя по причине: \(error)")
                    onResponseWasReceived(.failure(error))
                }
            case .failure(let error):
                print("Ошибка получения данных с сервера: \(error)")
                onResponseWasReceived(.failure(error))
            }
        }
    }
}
