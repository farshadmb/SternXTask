//
//  PostRepository.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift

protocol PostRepository {
    
    func getPosts() -> Single<[PostDto]>
}
