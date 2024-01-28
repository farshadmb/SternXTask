//
//  DataProcessingStrategy.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import Foundation

///  The `DataProcessingStrategy` interface
protocol DataProcessingStrategy {
    
    /// Process and summerize the post activitys
    /// - Parameters:
    ///   - data: an `[PostDto]` items to be process on.
    ///   - completion: a closure callback. called when the processing operation is done.
    func process(data: [PostDto], completion: @escaping (Result<UserPostReport, Error>) -> Void)
}
