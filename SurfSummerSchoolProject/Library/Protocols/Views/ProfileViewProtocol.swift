//
//  ProfileViewProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 21.08.2022.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
    func showAlertBeforeLogout(message: String, cancelActionTitle: String, defaultActionTitle: String)
    func showErrorState(message: String)
    func stopLoadingAnimation()
}
