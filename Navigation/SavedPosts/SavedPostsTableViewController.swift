//
//  SavedPostsTableViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 23.11.2022.
//

import UIKit
import StorageService
import CoreData

class SavedPostsTableViewController: UITableViewController {
    
    // MARK: - Variables
    var fetchedResultsController: NSFetchedResultsController<DBPost>!
    
    var searchText: String = ""
    
    var postsArray: [DBPost] {
        if searchText == "" {
            return CoreDataManager.shared.dbPosts
        } else {
            return CoreDataManager.shared.getFilteredPostsByAuthor(author: searchText)
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func setView() {
        view.backgroundColor = .white
        self.navigationItem.title = "saved_posts".localize
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        setBarButtons()
        initFetchResultsController()
    }
    
    private func setBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(searchBarButtonTapped))
        let cancelSearchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.slash"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(cancelSearchBarButtonTapped))
            
        self.navigationItem.rightBarButtonItems = [cancelSearchBarButtonItem, searchBarButtonItem]
    }
    
    @objc private func searchBarButtonTapped() {
        TextPicker.defaultPicker.getText(showIn: self,
                                         title: "filter_by_author".localize,
                                         placeholder: "enter_author".localize,
                                         completion: {(authorName) in
            self.searchText = authorName
            self.initFetchResultsController()
            self.tableView.reloadData()
        })
    }
    
    @objc private func cancelSearchBarButtonTapped() {
        searchText = ""
        self.initFetchResultsController()
        tableView.reloadData()
    }
    
    func initFetchResultsController() {
        let request = DBPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "postId", ascending: true)]
        if searchText != ""
        {
            request.predicate = NSPredicate(format: "author contains[c] %@", searchText)
        }
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.contextMain, sectionNameKeyPath: nil, cacheName: nil)
        try? frc.performFetch()
        fetchedResultsController = frc
        fetchedResultsController.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let dbPost = fetchedResultsController.object(at: indexPath)
        postCell.setupCell(model: dbPost.convertToPost())
        return postCell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedPost = fetchedResultsController.object(at: indexPath)
            CoreDataManager.shared.deletePost(dbPost: deletedPost)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    
}

// MARK: - Extensions

extension SavedPostsTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
                case .insert:
                    guard let newIndexPath = newIndexPath else { return }
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                case .delete:
                    guard let indexPath = indexPath else { return }
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                case .move:
                    guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
                    tableView.moveRow(at: indexPath, to: newIndexPath)
                case .update:
                    guard let indexPath = indexPath else { return }
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                @unknown default:
                    print("Fatal error")
                }
    }
}
