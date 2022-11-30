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
    
    var dbPosts: [DBPost] = []
    
    init() {
        fetchPosts()
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer (name: "VKData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
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
            let dbPosts = try persistentContainer.viewContext.fetch(request)
            self.dbPosts = dbPosts
        } catch {
            self.dbPosts = []
        }
    }
    
    func addPost(post: Post) {
        let dbPost = DBPost(context: persistentContainer.viewContext)
        dbPost.title = post.title
        dbPost.author = post.author
        dbPost.postDescription = post.description
        dbPost.image = post.image
        dbPost.likes = Int32(post.likes)
        dbPost.views = Int32(post.views)
        saveContext()
        fetchPosts()
    }
    
    func deletePost(dbPost: DBPost) {
        persistentContainer.viewContext.delete(dbPost)
        saveContext()
        fetchPosts()
    }
    
}
