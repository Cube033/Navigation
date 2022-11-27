//
//  DBPostExtension.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 27.11.2022.
//

import CoreData
import StorageService

extension DBPost {
    
    func convertToPost() -> Post {
        var post = Post(title: title ?? "",
                        description: postDescription ?? "",
                        image: image ?? "")
        post.author = author ?? ""
        post.likes = Int(likes)
        post.views = Int(views)
        return post
    }
    
}
