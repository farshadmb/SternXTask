//
//  ReportDataProcessingStrategy.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

final class ReportDataProcessingStrategy: DataProcessingStrategy {
    
    let operationQueue: DispatchQueue
    
    init(operationQueue: DispatchQueue) {
        self.operationQueue = operationQueue
    }
    
    func process(data: [PostDto],
                 completion: @escaping (Result<UserPostReport, Error>) -> Void) {
        operationQueue.async {
            let report = UserPostReport()
            var userDic = [Int: User]()
            
            for postDto in data {
                var user: User
                if let findUser = userDic[postDto.userId] {
                    user = findUser
                }else {
                    user = User(id: postDto.userId)
                    userDic[user.id] = user
                }
                
                let post = Post(id: postDto.id, user: user, title: postDto.title, body: postDto.body)
                user.averageCharacters = (user.averageCharacters * user.postCount + post.bodyCount) / (user.postCount + 1)
                user.posts.append(post)
            }
            
            report.topMostUsers = Array(userDic.values.sorted(by: { $0.postCount > $1.postCount }).prefix(5))
            report.users = userDic.values.map { $0 }
            completion(.success(report))
        }
    }
}
