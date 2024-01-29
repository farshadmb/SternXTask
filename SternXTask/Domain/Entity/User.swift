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
    var totalPostLength: Int = 0
    
    init(id: Int, posts: [Post] = [], averageCharacters: Int = 0, totalPostLength: Int = 0) {
        self.id = id
        self.posts = posts
        self.averageCharacters = averageCharacters
        self.totalPostLength = totalPostLength
    }
    
}
