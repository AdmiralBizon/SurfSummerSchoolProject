//
//  ImageLoader.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 08.08.2022.
//

import UIKit
import Foundation

final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private init() {}
    
    private var imageCache = NSCache<NSString, UIImage>()
    private let session = URLSession(configuration: .default)
    
    func loadImage(from url: URL, _ onLoadWasCompleted: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            onLoadWasCompleted(.success(cachedImage))
            return
        }
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                onLoadWasCompleted(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                onLoadWasCompleted(.success(image))
            }
            
        }.resume()
    }

 }
