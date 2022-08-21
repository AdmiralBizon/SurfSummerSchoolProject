//
//  AuthService.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import Foundation

struct AuthService {
    
    let loginDataTask = BaseNetworkTask<AuthRequestModel, AuthResponseModel>(
        isNeedInjectToken: false,
        method: .post,
        path: "auth/login"
    )
    
    let logoutDataTask = BaseNetworkTask<String, EmptyModel>(
        isNeedInjectToken: true,
        method: .post,
        path: "auth/logout"
    )
    
    func performLoginRequestAndSaveCredentials(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, Error>) -> Void
    ) {
        loginDataTask.performRequest(input: credentials) { result in
            switch result {
            case .success(let responseModel):
                do {
                    
                    let userCredentials = UserCredentialsManager.shared.prepareCredentials(login: credentials.phone, password: credentials.password, token: responseModel.token)
                    
                    try UserCredentialsManager.shared.saveCredentials(userCredentials)

                    if let savedUserInfo = CoreDataManager.shared.searchUser(key: "id", value: responseModel.userInfo.id) {
                        CoreDataManager.shared.updateUser(savedData: savedUserInfo, newData: responseModel.userInfo)
                    } else {
                        CoreDataManager.shared.createUser(userInfo: responseModel.userInfo)
                    }
                    
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
    
    func performLogoutRequestAndRemoveCredentials(
        _ onResponseWasReceived: @escaping (_ result: Result<EmptyModel, Error>) -> Void
    ) {
        
        do {
            let tokenData = try UserCredentialsManager.shared.getCredentials().token
            
            logoutDataTask.performRequest(input: tokenData.token) { result in
                switch result {
                case .success(let responseModel):
                    print(responseModel)
                    
                    do {
                        try UserCredentialsManager.shared.removeCredentials()
                        URLCache.shared.removeAllCachedResponses()
                    } catch {
                        print("Ошибка удаления данных пользователя по причине: \(error)")
                        onResponseWasReceived(.failure(error))
                    }
                    
                    onResponseWasReceived(.success(responseModel))
                case .failure(let error):
                    print("Ошибка получения данных с сервера: \(error)")
                    onResponseWasReceived(.failure(error))
                }
            }
        } catch {
            print("Ошибка получения токена по причине: \(error)")
            onResponseWasReceived(.failure(error))
        }

    }
    
}
