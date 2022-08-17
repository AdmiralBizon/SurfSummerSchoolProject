//
//  LocalStorageProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 17.08.2022.
//

import Foundation

protocol LocalStorageKeysProtocol {
    var rawValue: String { get }
}

protocol LocalStorageProtocol {
    func value<T:Codable>(for key: LocalStorageKeysProtocol) -> T?
    func set<T:Codable>(value: T?, for key: LocalStorageKeysProtocol)
}
