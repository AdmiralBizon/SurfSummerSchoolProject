//
//  BaseViewProtocol.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 16.08.2022.
//

import Foundation

protocol BaseViewProtocol: AnyObject {
    func showPosts(_ posts: [DetailItemModel])
    func showEmptyState()
    func showDetails(for item: DetailItemModel)
}
