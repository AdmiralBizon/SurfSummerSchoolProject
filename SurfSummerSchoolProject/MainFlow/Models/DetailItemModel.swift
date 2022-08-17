//
//  DetailItemModel.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 05.08.2022.
//

import Foundation

struct DetailItemModel: Codable {
    
    // MARK: - Properties
    
    let id: String
    let imageUrlInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String

    // MARK: - Initialization
    
    internal init(id: String,
                  imageUrlInString: String,
                  title: String,
                  isFavorite: Bool,
                  content: String,
                  dateCreation: Date) {
        
        self.id = id
        self.imageUrlInString = imageUrlInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        self.dateCreation = formatter.string(from: dateCreation)
    }

}

// MARK: - Equatable

extension DetailItemModel: Equatable {
    static func == (lhs: DetailItemModel, rhs: DetailItemModel) -> Bool {
        lhs.id == rhs.id
    }
}
