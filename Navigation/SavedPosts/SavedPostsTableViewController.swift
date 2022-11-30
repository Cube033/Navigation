//
//  SavedPostsTableViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 23.11.2022.
//

import UIKit

class SavedPostsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Сохраненные записи"
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.dbPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let dbPost = CoreDataManager.shared.dbPosts[indexPath.row]
        postCell.setupCell(model: dbPost.convertToPost())
        return postCell
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedPost = CoreDataManager.shared.dbPosts[indexPath.row]
            CoreDataManager.shared.deletePost(dbPost: deletedPost)
            tableView.reloadData()
        }
    }
    
}
