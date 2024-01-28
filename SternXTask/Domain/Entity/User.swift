//
//  User.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

class User {
    
    let id: Int
    var posts: [Post] = []
    var averageCharacters: Int = 0
    var postCount: Int { posts.count }
    
    init(id: Int, posts: [Post] = [], avarageCharecter: Int = 0) {
        self.id = id
        self.posts = posts
        self.averageCharacters = avarageCharecter
    }
    
}
