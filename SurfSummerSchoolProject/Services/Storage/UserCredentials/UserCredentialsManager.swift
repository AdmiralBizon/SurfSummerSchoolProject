//
//  UserCredentialsManager.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 20.08.2022.
//

import Foundation

final class UserCredentialsManager {
    
    // MARK: - Constants
    
    private enum Constants {
        static let applicationNameInKeyChain = "com.surf.education.project"
        static let userCredentialsKey = "userCredentials"
    }
    
    // MARK: - Public properties
    
    static let shared = UserCredentialsManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public methods
    
    func prepareCredentials(login: String, password: String, token: String)-> UserCredentials {
        let tokenContainer = TokenContainer(token: token, receivingDate: Date())
        return UserCredentials(login: login, password: password, token: tokenContainer)
    }
    
    func getCredentials() throws -> UserCredentials {
        let queryDictionaryForGettingCredentials: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.userCredentialsKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]
        
        var credentialsInResult: AnyObject?
        let status = SecItemCopyMatching(queryDictionaryForGettingCredentials as CFDictionary, &credentialsInResult)
        
        try throwErrorFromStatusIfNeeded(status)
        
        guard let data = credentialsInResult as? Data else {
            throw Error.credentialsWereNotFoundInKeyChainOrCantRepresentAsData
        }
        
        let retrivingCredentials = try JSONDecoder().decode(UserCredentials.self, from: data)
        
        return retrivingCredentials
    }
    
    func saveCredentials(_ credentials: UserCredentials) throws {
        try removeCredentials()
        
        let credentialsInData = try JSONEncoder().encode(credentials)
        let queryDictionaryForSavingCredentials: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.userCredentialsKey as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecValueData: credentialsInData as AnyObject
        ]
        
        let status = SecItemAdd(queryDictionaryForSavingCredentials as CFDictionary, nil)
        try throwErrorFromStatusIfNeeded(status)
    }
    
    func removeCredentials() throws {
        let queryDictionaryForDeleteCredentials: [CFString: AnyObject] = [
            kSecAttrService: Constants.applicationNameInKeyChain as AnyObject,
            kSecAttrAccount: Constants.userCredentialsKey as AnyObject,
            kSecClass: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(queryDictionaryForDeleteCredentials as CFDictionary)
        try throwErrorFromStatusIfNeeded(status)
    }
    
}

// MARK: - Private methods

private extension UserCredentialsManager {
    
    enum Error: Swift.Error {
        case unknownError(status: OSStatus)
        case keyIsAlreadyInKeyChain
        case credentialsWereNotFoundInKeyChainOrCantRepresentAsData
    }
    
    func throwErrorFromStatusIfNeeded(_ status: OSStatus) throws {
        guard status == errSecSuccess || status == -25300 else {
            throw Error.unknownError(status: status)
        }
        
        guard status != -25299 else {
            throw Error.keyIsAlreadyInKeyChain
        }
    }
}
