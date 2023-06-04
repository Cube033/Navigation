//
//  FeedNavigationController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 04.06.2023.
//

import UIKit
import StorageService

class FeedNavigationController: UITableViewController {

    let feedCoordinator: FeedCoordinator? = nil
    
    let postArray: [Post] = Post.getPostArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(FeedHeaderTableViewCell.self, forCellReuseIdentifier: "FeedHeaderTableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postArray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            
            let feedHeaderCell = tableView.dequeueReusableCell(withIdentifier: "FeedHeaderTableViewCell", for: indexPath) as! FeedHeaderTableViewCell
            return feedHeaderCell
        } else {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            postCell.setupCell(model: postArray[indexPath.row])
            postCell.backgroundColor = Palette.viewControllerBackgroundColor
            return postCell
        }
    }
}
