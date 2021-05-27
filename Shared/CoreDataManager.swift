//
//  CoreDataManager.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/26/21.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Yelper")
        container.loadPersistentStores { (storeDescription, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetchFavorites() -> [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            
        do {
            return try getContext().fetch(request)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    
    func deleteFavorite(_ favorite: Favorite, completion: (Error?) -> ()) {
        let context = getContext()
        context.delete(favorite)
        
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    // MARK: - create
    func addFavorite(businessId: String, completion: (Favorite?, Error?) -> ()) {
        let context = getContext()
        let favorite = Favorite(context: context)
        favorite.businessId = businessId
        favorite.createdAt = Date()
        
        do {
            try context.save()
            completion(favorite, nil)
        } catch {
            completion(nil, error)
        }
    }
}
