//
//  LocalStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 17.08.2022.
//

import Foundation

enum LocalStorageKeys: String, LocalStorageKeysProtocol {
    case favorites
}

struct LocalStorage: LocalStorageProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    func value<T:Codable>(for key: LocalStorageKeysProtocol) -> T? {
        guard let savedValue = userDefaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }
        
        if let value = try? JSONDecoder().decode(T.self, from: savedValue) {
            return value
        }
        return nil
    }
    
    func set<T:Codable>(value: T?, for key: LocalStorageKeysProtocol) {
        if let encodedObject = try? JSONEncoder().encode(value) {
            userDefaults.set(encodedObject, forKey: key.rawValue)
        }
    }
    
}
