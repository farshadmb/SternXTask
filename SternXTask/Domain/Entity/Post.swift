//
//  Post.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

struct Post {
    
    let id: Int
    let user: User
    let title: String
    let body: String
    
    var bodyCount: Int { body.count }
}
