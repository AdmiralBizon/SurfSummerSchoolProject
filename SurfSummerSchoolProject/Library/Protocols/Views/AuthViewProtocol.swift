//
//  AuthViewProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 19.08.2022.
//

import Foundation

protocol AuthViewProtocol: AnyObject {
    func showValidationStatus(status: ValidationStatus)
    func showErrorState(message: String)
    func stopLoadingAnimation()
}
