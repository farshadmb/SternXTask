//
//  PostDto.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

struct PostDto: Codable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
