//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 23.11.2022.
//

import CoreData
import StorageService

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    enum CoreDataActionResult {
        case success(String)
        case failure(String)
    }
    
    var dbPosts: [DBPost] = []
    
    lazy var contextMain: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        context.automaticallyMergesChangesFromParent = true
        return context
    }()

    lazy var contextBackground: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: "VKData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    init() {
        fetchPosts()
    }
    
    private func saveContext (isMainContext: Bool) {
        let context = isMainContext ? contextMain : contextBackground
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchPosts(){
        let request = DBPost.fetchRequest()
        do {
            let dbPosts = try contextMain.fetch(request)
            self.dbPosts = dbPosts
        } catch {
            self.dbPosts = []
        }
    }
    
    func addPost(post: Post) -> CoreDataActionResult{
        if !isPostSaved(id: post.id) {
            let dbPost = DBPost(context: contextBackground)
            dbPost.postId = Int32(post.id)
            dbPost.title = post.title
            dbPost.author = post.author
            dbPost.postDescription = post.description
            dbPost.image = post.image
            dbPost.likes = Int32(post.likes)
            dbPost.views = Int32(post.views)
            saveContext(isMainContext: false)
            fetchPosts()
            return .success("added_to_favorites".localized)
        } else {
            return .failure("already_in_favorites".localized)
        }
    }
    
    func deletePost(dbPost: DBPost) {
        contextMain.delete(dbPost)
        saveContext(isMainContext: true)
        fetchPosts()
    }
    
    func isPostSaved(id: Int) -> Bool {
        let postId = Int32(id)
        let request = DBPost.fetchRequest()
        request.predicate = NSPredicate(format: "postId == %ld", postId)
        do {
            if let _ = try contextBackground.fetch(request).first {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func getFilteredPostsByAuthor(author: String) -> [DBPost] {
        let request = DBPost.fetchRequest()
        request.predicate = NSPredicate(format: "author LIKE %@", author)
        do {
            let dbPosts = try contextMain.fetch(request)
            return dbPosts
        } catch {
            return []
        }
    }
}
