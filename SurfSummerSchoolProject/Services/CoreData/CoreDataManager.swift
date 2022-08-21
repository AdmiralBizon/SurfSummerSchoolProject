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
    
    init(modelName: String) {
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
        savedData.id = newData.id
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

// MARK: - Private methods

private extension CoreDataManager {
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print ("An error ocurred while saving data: \(error)")
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
            print ("An error ocurred while fetching data: \(error)")
            return nil
        }
    }
    
}
