//
//  Validator.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import Foundation

enum ValidationStatus {
    case emptyLogin
    case emptyPassword
    case loginDoesNotMatchMask
    case passwordDoesNotMatchLength
    case success
}

struct Validator {
    
    enum Constants {
        static let phoneMask = "+ X (XXX) XXX XX XX"
        static let phoneMaskToRequest = "+XXXXXXXXXXX"
        static let controlPhone = "77777777777"
        static let minimumPasswordLength = 6
        static let maximumPasswordLength = 255
    }
    
    static func applyPhoneMask(phoneNumber: String, mask: String = "") -> String {
        guard !phoneNumber.isEmpty else {
            return ""
        }
        
        let mask = !mask.isEmpty ? mask : Constants.phoneMask
        
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var maskedPhone: String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                maskedPhone.append(number[index])
                index = number.index(after: index)
            } else {
                maskedPhone.append(character)
            }
        }
        
        return maskedPhone
    }
    
    static func unmask(phoneNumber: String) -> String {
        applyPhoneMask(phoneNumber: phoneNumber, mask: Constants.phoneMaskToRequest)
    }
    
    static func validateLogin(login: String) -> ValidationStatus {
        if login.isEmpty {
            return .emptyLogin
        }
        
        let maskedLogin = applyPhoneMask(phoneNumber: Constants.controlPhone)
        if login.count != maskedLogin.count {
            return .loginDoesNotMatchMask
        }
        
        return .success
    }
    
    static func validatePassword(password: String) -> ValidationStatus {
        if password.isEmpty {
            return .emptyPassword
        }
        
        let passwordLengthRange = Constants.minimumPasswordLength...Constants.maximumPasswordLength
        if !passwordLengthRange.contains(password.count) {
            return .passwordDoesNotMatchLength
        }
        
        return .success
    }
    
}
