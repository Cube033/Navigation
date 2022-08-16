//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий on 15.08.2022.
//

import Foundation

public struct Post {
    var title: String
    var author: String = ""
    var description: String = ""
    var image: String
    var likes: Int = 0
    var views: Int = 0
    
    static func getPostArray() -> [Post] {
        var postArray = [Post]()
        postArray.append(Post(title: "1", image: "myAvatarImage"))
        postArray.append(Post(title: "2", image: "myAvatarImage"))
        postArray.append(Post(title: "3", image: "myAvatarImage"))
        postArray.append(Post(title: "4", image: "myAvatarImage"))
        return postArray
    }
}
