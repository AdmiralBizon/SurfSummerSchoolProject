//
//  CoreDataManager.swift
//  SurfSummerSchoolProject
//
//  Created by Ilya on 20.08.2022.
//

import Foundation
import CoreData

final class CoreDataManager {
   
    // MARK: - Constants
    
    private enum Constants {
        static let modelName = "Users"
    }
    
    // MARK: - Public properties
    
    static let shared = CoreDataManager(modelName: Constants.modelName)
    
    // MARK: - Private properties
    
    private let persistentContainer: NSPersistentContainer
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Initializers
    
    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    // MARK: - Public methods
    
    func load() {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
    
}

// MARK: - Users

extension CoreDataManager {
    func createUser(userInfo: UserInfoModel) {
        let user = User(context: viewContext)
        user.id = userInfo.id
        user.phone = userInfo.phone
        user.email = userInfo.email
        user.firstName = userInfo.firstName
        user.lastName = userInfo.lastName
        user.avatar = userInfo.avatar
        user.city = userInfo.city
        user.about = userInfo.about
        
        save()
    }
    
    func updateUser(savedData: User, newData: UserInfoModel) {
        savedData.email = newData.email
        savedData.firstName = newData.firstName
        savedData.lastName = newData.lastName
        savedData.avatar = newData.avatar
        savedData.city = newData.city
        savedData.about = newData.about
        
        save()
    }
    
    func removeUser( _ id: String) {
        if let user = searchUser(key: "id", value: id) {
            viewContext.delete(user)
            save()
        }
    }
    
    func searchUser(key: String, value: String) -> User? {
        let searchPredicate = NSPredicate(format: "\(key) == %@", value)
        return fetchUser(predicate: searchPredicate)
    }
}

// MARK: - Favorites

extension CoreDataManager {
    
    func getFavorites(userPhone: String?) -> [Favorites] {
        guard let userPhone = userPhone,
              let user = searchUser(key: "phone", value: userPhone) else {
                  return []
              }
        
        let searchPredicate = NSPredicate(format: "owner == %@", user)
        return fetchFavorites(predicate: searchPredicate)
    }
    
    func addToFavorites(userPhone: String?, item: DetailItemModel) {
        guard !item.id.isEmpty,
              let userPhone = userPhone,
              let user = searchUser(key: "phone", value: userPhone) else {
                  return
              }
       
        let searchPredicate = NSPredicate(format: "owner = %@ && id = %@", user, item.id)
        
        if fetchFavorites(predicate: searchPredicate).isEmpty {
            let newItem = Favorites(context: viewContext)
            newItem.id = item.id
            newItem.imageURL = item.imageUrlInString
            newItem.title = item.title
            newItem.content = item.content
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            
            newItem.dateCreation = formatter.date(from: item.dateCreation)
            
            user.addToFavoritesPosts(newItem)
            save()
        }
    }
    
    func removeFromFavorites(userPhone: String?, itemId: String) {
        if let itemToRemove = getItemFromFavorites(userPhone: userPhone, itemId: itemId) {
            viewContext.delete(itemToRemove)
            save()
        }
    }
    
    func getItemFromFavorites(userPhone: String?, itemId: String) -> Favorites? {
        guard !itemId.isEmpty,
              let userPhone = userPhone,
              let user = searchUser(key: "phone", value: userPhone) else {
                  return nil
              }
       
        let searchPredicate = NSPredicate(format: "owner = %@ && id = %@", user, itemId)
        let items = fetchFavorites(predicate: searchPredicate)
        
        return !items.isEmpty ? items.first : nil
    }
    
}

// MARK: - Private methods

private extension CoreDataManager {
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print ("Не удалось сохранить данные в CoreData по причине: \(error)")
            }
        }
    }
    
    func fetchUser(predicate: NSPredicate) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let user = try viewContext.fetch(request).first
            return user
        } catch {
            print ("Не удалось получить данные из CoreData по причине: \(error)")
            return nil
        }
    }
    
    func fetchFavorites(predicate: NSPredicate) -> [Favorites] {
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = predicate
        do {
            return try viewContext.fetch(request)
        } catch {
            print ("Не удалось получить данные из CoreData по причине: \(error)")
            return []
        }
    }
    
}
