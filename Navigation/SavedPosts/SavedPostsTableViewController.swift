//
//  SavedPostsTableViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 23.11.2022.
//

import UIKit
import StorageService

class SavedPostsTableViewController: UITableViewController {
    
//    let searchController = UISearchController(searchResultsController: nil)
    var searchText: String = ""
    
    var postsArray: [DBPost] {
        if searchText == "" {
            return CoreDataManager.shared.dbPosts
        } else {
            return CoreDataManager.shared.getFilteredPostsByAuthor(author: searchText)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Сохраненные записи"
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
//        searchController.searchResultsUpdater = self
//        navigationItem.searchController = searchController
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc private func searchBarButtonTapped() {
        TextPicker.defaultPicker.getText(showIn: self,
                                         title: "фильтр по автору",
                                         placeholder: "Введите автора",
                                         completion: {(authorName) in
            self.searchText = authorName
            self.tableView.reloadData()
        })
        
    }
    
    @objc private func cancelSearchBarButtonTapped() {
        searchText = ""
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let dbPost = postsArray[indexPath.row]
        postCell.setupCell(model: dbPost.convertToPost())
        return postCell
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedPost = postsArray[indexPath.row]
            CoreDataManager.shared.deletePost(dbPost: deletedPost)
            tableView.reloadData()
        }
    }
    
}

//extension SavedPostsTableViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController.searchBar.text!)
//    }
//}
