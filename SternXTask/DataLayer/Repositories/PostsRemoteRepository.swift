//
//  PostsRemoteRepository.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class PostRemoteRepository: PostRepository {
   
    let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
    
    func getPosts() -> Single<[PostDto]> {
        let request = APIParametersRequest(url: "https://jsonplaceholder.typicode.com/posts")
        return client.execute(request: request).asSingle()
    }
    
}
